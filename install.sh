#!/usr/bin/env bash
# install.sh — 一键安装入口，供 curl | bash 调用
# 用法：curl -fsSL https://raw.githubusercontent.com/WanGXUUvU/OneMore_vibe-coding/main/install.sh | bash

set -e

REPO="https://github.com/WanGXUUvU/OneMore_vibe-coding.git"
TMP_DIR="$(mktemp -d)"

cleanup() { rm -rf "$TMP_DIR"; }
trap cleanup EXIT

echo ""
echo "  Cloning OneMore_vibe-coding..."
git clone --depth 1 --quiet "$REPO" "$TMP_DIR"

cd "$TMP_DIR"
chmod +x generate.sh
./generate.sh
