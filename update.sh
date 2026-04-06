#!/bin/bash
set -euo pipefail

DOTFILES="$(cd "$(dirname "$0")" && pwd)"

case "$(uname -s)" in
  Linux*)  PLATFORM="linux" ;;
  Darwin*) PLATFORM="mac" ;;
  *)       echo "Unsupported OS"; exit 1 ;;
esac

echo "Pulling latest dotfiles..."
cd "$DOTFILES"
git pull --rebase

echo ""
echo "Re-stowing common configs..."
for dir in "$DOTFILES/common"/*/; do
  name=$(basename "$dir")
  stow -d "$DOTFILES/common" -t "$HOME" -R "$name"
done

if [ -d "$DOTFILES/$PLATFORM" ]; then
  echo "Re-stowing $PLATFORM configs..."
  for dir in "$DOTFILES/$PLATFORM"/*/; do
    name=$(basename "$dir")
    stow -d "$DOTFILES/$PLATFORM" -t "$HOME" -R "$name"
  done
fi

echo ""
echo "Done! All configs up to date."
