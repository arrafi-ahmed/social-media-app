#!/bin/bash

set -euo pipefail
#set -x

SKIP_GIT=false

# === Parse Flags ===
for arg in "$@"; do
  case "$arg" in
    --skip-git)
      SKIP_GIT=true
      shift
      ;;
    *)
      echo "❌ Unknown argument: $arg"
      exit 1
      ;;
  esac
done

# --- Local Environment Files ---
LOCAL_BACKEND_ENV="./backend/.env.production"
LOCAL_FRONTEND_ENV="./frontend/.env.production"

# === Validate .env Files ===
echo "🔍 Checking for environment files..."
[[ -f "$LOCAL_BACKEND_ENV" ]] || { echo "❌ Missing $LOCAL_BACKEND_ENV"; exit 1; }
[[ -f "$LOCAL_FRONTEND_ENV" ]] || { echo "❌ Missing $LOCAL_FRONTEND_ENV"; exit 1; }
echo "✅ Environment files found."

# === Extract SERVER_IP ===
set -a
source "$LOCAL_BACKEND_ENV"
set +a
: "${SERVER_IP:?Missing SERVER_IP in backend/.env.production}"

REMOTE="root@$SERVER_IP"
REMOTE_DIR="/root"
REMOTE_DEPLOY="$REMOTE_DIR/deploy-remote.sh"
REMOTE_ENV_FRONT="$REMOTE_DIR/.env.frontend.production"
REMOTE_ENV_BACK="$REMOTE_DIR/.env.backend.production"

# === 1. Git Push ===
echo "🚀 Git push (unless skipped)..."
if [ "$SKIP_GIT" = false ]; then
  git add .
  git commit -m "📦 Deploy commit on $(date +'%Y-%m-%d %H:%M:%S')" || echo "ℹ️ Nothing to commit"
  git push origin main
else
  echo "⏭️ Skipping Git push (--skip-git)"
fi

# === 2. Upload Files ===
echo "📤 Uploading files to $REMOTE..."
scp deploy-remote.sh "$REMOTE:$REMOTE_DEPLOY"
scp "$LOCAL_FRONTEND_ENV" "$REMOTE:$REMOTE_ENV_FRONT"
scp "$LOCAL_BACKEND_ENV" "$REMOTE:$REMOTE_ENV_BACK"

echo "✅ Files uploaded successfully."

# === 3. Execute Remote Script ===
echo "📡 Executing deploy on $REMOTE..."
ssh "$REMOTE" "chmod +x $REMOTE_DEPLOY && $REMOTE_DEPLOY"

echo "🎉 Deployment triggered on $REMOTE. Monitor logs there if needed."
