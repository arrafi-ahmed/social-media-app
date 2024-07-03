#!/bin/bash

echo "----- Deployment script started ---"
# Define variables for directories and repositories
REPO_NAME="social-media-app"
PROJECT_ROOT="/usr/local/lsws/wayzaway"

# Auto generated
REPO_URL="https://github.com/arrafi-ahmed/$REPO_NAME.git"
REPO_DIR="$PROJECT_ROOT/$REPO_NAME"
HTML_DIR="$PROJECT_ROOT/html"

# Exit immediately if a command exits with a non-zero status
set -e

# Function to remove existing files and directories in /usr/local/lsws/wayzaway/html
remove_existing_files() {
  local files=(
    assets
    favicon.ico
    img
    index.html
    maintanance.html
    site.webmanifest
  )
  for file in "${files[@]}"; do
    if [ -e "$HTML_DIR/$file" ]; then
      if [ -d "$HTML_DIR/$file" ]; then
        rm -rf "$HTML_DIR/$file" && \
        echo "----- Directory $HTML_DIR/$file removed..."
      else
        rm -f "$HTML_DIR/$file" && \
        echo "----- File $HTML_DIR/$file removed..."
      fi
    fi
  done
}

# Check if the project directory exists, and if it does, remove it
if [ -d "$REPO_DIR" ]; then
  echo "----- Directory $REPO_DIR already exists..."
  rm -rf "$REPO_DIR" && \
  echo "----- Directory $REPO_DIR removed..."
fi

# Change directory to the project directory and clone the repository
cd "$PROJECT_ROOT" && \
git clone "$REPO_URL" && \
echo "----- Git clone done..."

# Navigate to the client directory, setup the client environment, and build the client application
cd "$REPO_DIR/client" && \
npm run setup && \
npm run build && \
remove_existing_files && \
mv dist/* "$HTML_DIR" && \
echo "----- Client build done..."

# Navigate to the Node directory and clean up (remove all files except 'public')
cd "$HTML_DIR/node" && \
find . -mindepth 1 -maxdepth 1 ! -name 'public' -exec rm -rf {} + && \
echo "----- Project Node dir cleaned..."

# Sync API files to the node directory (excluding 'public' folder)
rsync -av --progress --exclude public "$REPO_DIR/api/" "$HTML_DIR/node" && \
echo "----- Project Node synced..."

# Navigate to the node directory and setup the node environment
cd "$HTML_DIR/node" && \
npm run setup && \
echo "----- Api setup done..." && \

if [ -d "$REPO_DIR" ]; then
  rm -rf "$REPO_DIR" && \
  echo "----- Junk directory $REPO_DIR removed..."
fi

#After deployment change file permission of public folder:
find "$HTML_DIR/node/public" -type f -exec chmod 777 {} \; && \
find "$HTML_DIR/node/public" -type d -exec chmod 777 {} \; && \
echo "----- Public dir & files permission modified..."

# Function to check if ImageMagick is installed
check_imagick_installed() {
    if dpkg-query -W -f='${Status}' imagemagick 2>/dev/null | grep -q "install ok installed"; then
        echo "----- ImageMagick pre installed?: True..."
        return 0  # Return success
    else
        echo "----- ImageMagick pre installed?: False..."
        return 1  # Return failure
    fi
}

# Check if ImageMagick is installed
if ! check_imagick_installed; then
    # ImageMagick not installed, so install it
    DEBIAN_FRONTEND=noninteractive apt-get install -y imagemagick && \
    echo "----- ImageMagick installed..."
fi

echo "----- Deployment script ended ---"