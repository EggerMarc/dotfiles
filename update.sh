#!/bin/bash
set -euo pipefail

DOTFILES="$(cd "$(dirname "$0")" && pwd)"

echo "Pulling latest dotfiles..."
cd "$DOTFILES"
git pull --rebase

echo ""
echo "Re-running install to update symlinks..."
"$DOTFILES/install.sh"
