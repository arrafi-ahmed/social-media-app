#!/bin/bash

# Define variables for directories and repositories
REPO_NAME="social-media-app"
SERVER_ROOT="/usr/local/lsws/wayzaway/html"

# Auto generated
REPO_URL="https://github.com/arrafi-ahmed/$REPO_NAME.git"
CLIENT_DIR="$REPO_NAME/client"
API_DIR="$REPO_NAME/api"
NODE_DIR="node"

# Exit immediately if a command exits with a non-zero status
set -e

# Change directory to the project directory and clone the repository
cd "$SERVER_ROOT" && \
git clone "$REPO_URL" && \

# Navigate to the client directory, setup the client environment, and build the client application
cd "$SERVER_ROOT/$CLIENT_DIR" && \
npm run setup && \
npm run build && \
mv dist/* ../.. && \

# Navigate to the API directory and clean up (remove all files except 'public')
cd "$SERVER_ROOT/$API_DIR" && \
find . -mindepth 1 -maxdepth 1 ! -name 'public' -exec rm -rf {} + && \

# Sync API files to the node directory (excluding 'public' folder)
rsync -av --progress --exclude public "$SERVER_ROOT/$API_DIR/" "$SERVER_ROOT/$NODE_DIR" && \

# Navigate to the node directory and setup the node environment
cd "$SERVER_ROOT/$NODE_DIR" && \
npm run setup
