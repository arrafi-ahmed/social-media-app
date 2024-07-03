#!/bin/bash

# Define variables for directories and repositories
REPO_NAME="social-media-app"
PROJECT_ROOT="/usr/local/lsws/wayzaway"

# Auto generated
REPO_URL="https://github.com/arrafi-ahmed/$REPO_NAME.git"
REPO_DIR="$PROJECT_ROOT/$REPO_NAME"
HTML_DIR="$PROJECT_ROOT/html"

# Exit immediately if a command exits with a non-zero status
set -e

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
echo "----- Deploy completed successfully!"

if [ -d "$REPO_DIR" ]; then
  rm -rf "$REPO_DIR" && \
  echo "----- Junk directory $REPO_DIR removed..."
fi