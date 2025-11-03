#!/bin/bash

# set dev mode
#set -x

### === GLOBAL CONFIGURATION === ###
ROOT_DIR="/root"
REMOTE_FRONTEND_ENV="$ROOT_DIR/.env.frontend.production"
REMOTE_BACKEND_ENV="$ROOT_DIR/.env.backend.production"

echo "🔐 Checking environment files..."
if [ ! -f "$REMOTE_FRONTEND_ENV" ]; then
  echo "❌ Missing frontend env file: $REMOTE_FRONTEND_ENV"
  exit 1
fi

if [ ! -f "$REMOTE_BACKEND_ENV" ]; then
  echo "❌ Missing backend env file: $REMOTE_BACKEND_ENV"
  exit 1
fi

echo "🔑 Loading environment variables from $REMOTE_FRONTEND_ENV and $REMOTE_BACKEND_ENV..."
set -a
source "$REMOTE_FRONTEND_ENV"
source "$REMOTE_BACKEND_ENV"
set +a

: "${PROJECT_NAME:?Missing PROJECT_NAME (Git repo name) in env}"
: "${FRONTEND_DOMAIN:?Missing FRONTEND_DOMAIN (e.g., quthentic.com) in env}"
: "${FRONTEND_SITE_USER:?Missing FRONTEND_SITE_USER (e.g., quthentic) in env}"
: "${BACKEND_DOMAIN:?Missing BACKEND_DOMAIN (e.g., api.quthentic.com) in env}"
: "${BACKEND_SITE_USER:?Missing BACKEND_SITE_USER (e.g., quthentic-api) in env}"
: "${PORT:?Missing PORT (Node.js app port, e.g., 3000) in env}"
: "${DB_NAME:?Missing DB_NAME in env}"
: "${DB_USER:?Missing DB_USER in env}"
: "${DB_PASS:?Missing DB_PASS in env}"

FRONTEND_SITE_DIR="/home/$FRONTEND_SITE_USER/htdocs/$FRONTEND_DOMAIN"
BACKEND_SITE_DIR="/home/$BACKEND_SITE_USER/htdocs/$BACKEND_DOMAIN"

REPO_URL="https://github.com/arrafi-ahmed/$PROJECT_NAME.git"
GLOBAL_CLONE_DIR="/tmp/$PROJECT_NAME-clone"

set -e

echo "🚀 Starting unified deployment for $PROJECT_NAME."

echo "1.0 Ensuring base directory permissions..."
chmod o+x "/home/$FRONTEND_SITE_USER/htdocs" || true
chmod o+x "/home/$FRONTEND_SITE_USER" || true
chmod o+x "/home/$BACKEND_SITE_USER/htdocs" || true
chmod o+x "/home/$BACKEND_SITE_USER" || true

echo "2.0 Installing Node.js and npm (if missing)..."
if ! command -v node &> /dev/null; then
  curl -fsSL https://deb.nodesource.com/setup_20.x | bash -
  apt update
  apt install -y nodejs
fi

echo "3.0 Installing PM2 globally (if missing)..."
if ! command -v pm2 &> /dev/null; then
  npm install pm2@latest -g
fi

echo "4.0 Installing PostgreSQL (if missing)..."
if ! command -v psql &> /dev/null; then
  apt update
  apt install -y postgresql postgresql-contrib
  systemctl enable postgresql
  systemctl start postgresql
fi

echo "5.0 Configuring PostgreSQL database and user..."
if ! sudo -u postgres psql -tAc "SELECT 1 FROM pg_roles WHERE rolname='$DB_USER'" | grep -q 1; then
  sudo -u postgres psql -c "CREATE USER $DB_USER WITH ENCRYPTED PASSWORD '$DB_PASS';"
fi

if ! sudo -u postgres psql -tAc "SELECT 1 FROM pg_database WHERE datname='$DB_NAME'" | grep -q 1; then
  sudo -u postgres psql -c "CREATE DATABASE $DB_NAME WITH OWNER $DB_USER;"
fi

sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE $DB_NAME TO $DB_USER;"
sudo -u postgres psql -d "$DB_NAME" -c "GRANT ALL ON SCHEMA public TO $DB_USER;"

# Optional grants removed per user instruction

echo "6.0 Cloning repo into $GLOBAL_CLONE_DIR..."
rm -rf "$GLOBAL_CLONE_DIR"
git clone "$REPO_URL" "$GLOBAL_CLONE_DIR"

# === FRONTEND DEPLOYMENT ===
echo "7.0 Frontend Deployment ($FRONTEND_DOMAIN) as $FRONTEND_SITE_USER..."

mkdir -p "$FRONTEND_SITE_DIR"
echo "7.1 Copying frontend source and environment file..."
rm -rf "$FRONTEND_SITE_DIR/frontend"
cp -r "$GLOBAL_CLONE_DIR/frontend" "$FRONTEND_SITE_DIR/"
cp "$REMOTE_FRONTEND_ENV" "$FRONTEND_SITE_DIR/frontend/.env.production"

echo "7.2 Building frontend..."
cd "$FRONTEND_SITE_DIR/frontend"
npm cache clean --force
NODE_ENV=development npm install
NODE_ENV=production npm run build

echo "✅ Frontend build complete."

echo "7.3 Deploying built frontend files to $FRONTEND_SITE_DIR..."
DIST_DIR="$FRONTEND_SITE_DIR/frontend/dist"
echo "Cleaning up old frontend deployment (excluding ./frontend)..."
find "$FRONTEND_SITE_DIR" -mindepth 1 -path "$FRONTEND_SITE_DIR/frontend" -prune -o -exec rm -rf {} +
cp -r "$DIST_DIR"/* "$FRONTEND_SITE_DIR/"

echo "7.4 Setting ownership and permissions for frontend files..."
chown -R "$FRONTEND_SITE_USER:$FRONTEND_SITE_USER" "$FRONTEND_SITE_DIR"
find "$FRONTEND_SITE_DIR" -type d -exec chmod 755 {} \;
find "$FRONTEND_SITE_DIR" -type f -exec chmod 644 {} \;
chmod 600 "$FRONTEND_SITE_DIR/frontend/.env.production"

# === BACKEND DEPLOYMENT ===
echo "8.0 Backend Deployment ($BACKEND_DOMAIN) as $BACKEND_SITE_USER..."

mkdir -p "$BACKEND_SITE_DIR"

echo "8.1 Preserving backend public folder if exists..."
if [ -d "$BACKEND_SITE_DIR/backend/public" ] && [ "$(ls -A $BACKEND_SITE_DIR/backend/public 2>/dev/null)" ]; then
  mv "$BACKEND_SITE_DIR/backend/public" "$BACKEND_SITE_DIR/public_backup"
fi

echo "8.2 Copying backend source and environment file..."
rm -rf "$BACKEND_SITE_DIR/backend"
cp -r "$GLOBAL_CLONE_DIR/backend" "$BACKEND_SITE_DIR/"
cp "$REMOTE_BACKEND_ENV" "$BACKEND_SITE_DIR/backend/.env.production"

cd "$BACKEND_SITE_DIR/backend"
echo "8.3 Installing backend dependencies..."
npm install

echo "8.4 Restoring public folder if backed up..."
if [ -d "$BACKEND_SITE_DIR/public_backup" ]; then
  rm -rf "$BACKEND_SITE_DIR/backend/public"
  mv "$BACKEND_SITE_DIR/public_backup" "$BACKEND_SITE_DIR/backend/public"
fi

echo "8.5 Creating PM2 ecosystem config..."
cat <<EOF > "$BACKEND_SITE_DIR/backend/ecosystem.config.js"
module.exports = {
  apps: [{
    name: "$PROJECT_NAME-api",
    script: "app.js",
    cwd: "$BACKEND_SITE_DIR/backend",
    instances: 1,
    autorestart: true,
    watch: false,
    out_file: "./logs/pm2-out.log",
    error_file: "./logs/pm2-error.log",
    log_date_format: "YYYY-MM-DD HH:mm:ss",
    env_production: {
      NODE_ENV: "production",
      PORT: "$PORT"
    }
  }]
};
EOF

echo " 8.6 Creating PM2 logs dir..."
mkdir -p "$BACKEND_SITE_DIR/backend/logs"

echo "8.7 Setting ownership and permissions for backend files..."
chown -R "$BACKEND_SITE_USER:$BACKEND_SITE_USER" "$BACKEND_SITE_DIR"
find "$BACKEND_SITE_DIR" -type d -exec chmod 755 {} \;
find "$BACKEND_SITE_DIR" -type f -exec chmod 644 {} \;
chmod 600 "$BACKEND_SITE_DIR/backend/.env.production"
chmod -R o+rX "$GLOBAL_CLONE_DIR/backend"

echo "8.8 PM2 setup to run on boot..."

for svc_user in "$BACKEND_SITE_USER" root; do
  if systemctl list-units --all | grep -q "pm2-$svc_user.service"; then
    sudo systemctl stop "pm2-$svc_user.service" || true
    sudo systemctl disable "pm2-$svc_user.service" || true
    sudo rm "/etc/systemd/system/pm2-$svc_user.service"
  fi

done
sudo systemctl daemon-reload
sudo systemctl reset-failed

sudo -u "$BACKEND_SITE_USER" pm2 kill || true
sudo rm -rf "/home/$BACKEND_SITE_USER/.pm2"

sudo env PATH=$PATH:/usr/bin /usr/lib/node_modules/pm2/bin/pm2 startup systemd -u "$BACKEND_SITE_USER" --hp "/home/$BACKEND_SITE_USER"
if [ $? -eq 0 ]; then
  echo "✅ PM2 startup configured."
else
  echo "❌ PM2 startup command failed."
  exit 1
fi

echo "8.9 Starting backend with PM2..."
sudo -u "$BACKEND_SITE_USER" pm2 start "$BACKEND_SITE_DIR/backend/ecosystem.config.js" --env production || sudo -u "$BACKEND_SITE_USER" pm2 restart "$PROJECT_NAME-api"
sudo -u "$BACKEND_SITE_USER" pm2 save

echo "9.0 Running DB schema migration if present..."
if [ -f "$GLOBAL_CLONE_DIR/backend/schema-pg.sql" ]; then
  chown postgres:postgres "$GLOBAL_CLONE_DIR/backend/schema-pg.sql"
  chmod 600 "$GLOBAL_CLONE_DIR/backend/schema-pg.sql"
  sudo -u postgres psql -d "$DB_NAME" -f "$GLOBAL_CLONE_DIR/backend/schema-pg.sql"

  # NEW: Ensure table-level and sequence-level privileges are granted
  sudo -u postgres psql -d "$DB_NAME" -c "GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO $DB_USER;"
  sudo -u postgres psql -d "$DB_NAME" -c "GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO $DB_USER;"
fi

echo "10.0 Cleaning up temporary files..."
rm -rf "$GLOBAL_CLONE_DIR"
rm -f "$ROOT_DIR/deploy-remote.sh" "$REMOTE_FRONTEND_ENV" "$REMOTE_BACKEND_ENV"
rm -rf "$FRONTEND_SITE_DIR/frontend"

echo "✅ Deployment complete! Visit: https://$FRONTEND_DOMAIN"

echo "🔍 Testing backend health at http://127.0.0.1:$PORT"

MAX_RETRIES=5
RETRY_INTERVAL=2
HEALTHCHECK_URL="http://127.0.0.1:$PORT/info"
SUCCESS=false

for ((i=1; i<=MAX_RETRIES; i++)); do
  if curl --fail --silent "$HEALTHCHECK_URL" > /dev/null; then
    echo "✅ Backend is healthy after $i attempt(s)."
    SUCCESS=true
    break
  else
    echo "Attempt $i: Backend not yet healthy. Retrying in ${RETRY_INTERVAL}s..."
    sleep $RETRY_INTERVAL
  fi
done

if [ "$SUCCESS" = false ]; then
  echo "❌ Backend health check failed after $MAX_RETRIES attempts. Something’s wrong."
  exit 1
fi
