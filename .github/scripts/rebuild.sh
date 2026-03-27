#!/usr/bin/env bash
set -euo pipefail

# Rebuild script for zfile-dev/docs
# Runs on existing source tree (no clone). Installs deps, runs pre-build steps, builds.

# --- Node version ---
# Docusaurus 3.4.0, Node 20
NODE_VERSION="20"
export NVM_DIR="${NVM_DIR:-$HOME/.nvm}"
if [ ! -f "$NVM_DIR/nvm.sh" ]; then
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
fi
source "$NVM_DIR/nvm.sh"
nvm install $NODE_VERSION
nvm use $NODE_VERSION

echo "Node: $(node --version)"
echo "npm: $(npm --version)"

# --- Package manager: Yarn classic (v1) ---
if ! yarn --version 2>/dev/null | grep -q "^1\."; then
    npm install -g yarn
fi

echo "Yarn: $(yarn --version)"

# --- Dependencies ---
yarn install --frozen-lockfile

# --- Build ---
yarn build

echo "[DONE] Build complete."
