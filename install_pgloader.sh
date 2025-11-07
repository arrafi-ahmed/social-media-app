#!/bin/bash
# Install pgloader on Ubuntu/Debian

echo "Installing pgloader..."

# Method 1: Try apt (Ubuntu/Debian)
if command -v apt-get &> /dev/null; then
    sudo apt-get update
    sudo apt-get install -y pgloader
    if command -v pgloader &> /dev/null; then
        echo "✓ pgloader installed via apt"
        pgloader --version
        exit 0
    fi
fi

# Method 2: Try snap
if command -v snap &> /dev/null; then
    sudo snap install pgloader
    if command -v pgloader &> /dev/null; then
        echo "✓ pgloader installed via snap"
        pgloader --version
        exit 0
    fi
fi

# Method 3: Build from source (if above fail)
echo "Installing dependencies for building from source..."
sudo apt-get install -y build-essential libssl-dev libzip-dev libsqlite3-dev \
    libfreetype6-dev libfontconfig1-dev libxml2-dev libyaml-dev \
    libcurl4-openssl-dev libz-dev libreadline-dev libedit-dev \
    sbcl unzip git

echo "Building pgloader from source..."
cd /tmp
git clone https://github.com/dimitri/pgloader.git
cd pgloader
make pgloader
sudo cp pgloader /usr/local/bin/

if command -v pgloader &> /dev/null; then
    echo "✓ pgloader installed from source"
    pgloader --version
else
    echo "✗ Installation failed. Please install manually."
    echo "See: https://github.com/dimitri/pgloader#installation"
fi
