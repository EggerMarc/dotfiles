#!/bin/bash
set -euo pipefail

DOTFILES="$(cd "$(dirname "$0")" && pwd)"

# Detect OS
case "$(uname -s)" in
  Linux*)  PLATFORM="linux" ;;
  Darwin*) PLATFORM="mac" ;;
  *)       echo "Unsupported OS"; exit 1 ;;
esac

echo "Platform: $PLATFORM"
echo "Dotfiles: $DOTFILES"

# Ensure stow is installed
if ! command -v stow &>/dev/null; then
  echo "Installing stow..."
  if [ "$PLATFORM" = "linux" ]; then
    sudo pacman -S --needed --noconfirm stow
  else
    brew install stow
  fi
fi

# Stow common configs
echo ""
echo ">>> Stowing common configs..."
for dir in "$DOTFILES/common"/*/; do
  name=$(basename "$dir")
  echo "  $name"
  stow -d "$DOTFILES/common" -t "$HOME" --adopt "$name"
done

# Stow platform-specific configs
if [ -d "$DOTFILES/$PLATFORM" ]; then
  echo ""
  echo ">>> Stowing $PLATFORM configs..."
  for dir in "$DOTFILES/$PLATFORM"/*/; do
    name=$(basename "$dir")
    echo "  $name"
    stow -d "$DOTFILES/$PLATFORM" -t "$HOME" --adopt "$name"
  done
fi

echo ""
echo "Done! All configs symlinked."
echo ""
echo "Note: --adopt was used, so any existing files were moved into"
echo "the dotfiles repo. Run 'git diff' to review and commit."
