#!/bin/bash
set -euo pipefail

DOTFILES="$(cd "$(dirname "$0")" && pwd)"

case "$(uname -s)" in
  Linux*)  PLATFORM="linux" ;;
  Darwin*) PLATFORM="mac" ;;
  *)       echo "Unsupported OS"; exit 1 ;;
esac

echo "Platform: $PLATFORM"
echo "Dotfiles: $DOTFILES"

link_config() {
  local src="$1"
  local dest="$2"

  if [ -e "$dest" ] && [ ! -L "$dest" ]; then
    echo "  backing up $dest -> ${dest}.bak"
    mv "$dest" "${dest}.bak"
  fi

  mkdir -p "$(dirname "$dest")"
  ln -sfn "$src" "$dest"
  echo "  $dest -> $src"
}

# Common configs
echo ""
echo ">>> Linking common configs..."
for dir in "$DOTFILES/common"/*/; do
  name=$(basename "$dir")
  case "$name" in
    bash)     link_config "$dir/.bashrc" "$HOME/.bashrc" ;;
    starship) link_config "$dir/starship.toml" "$HOME/.config/starship.toml" ;;
    *)        link_config "$dir" "$HOME/.config/$name" ;;
  esac
done

# Platform-specific configs
if [ -d "$DOTFILES/$PLATFORM" ]; then
  echo ""
  echo ">>> Linking $PLATFORM configs..."
  for dir in "$DOTFILES/$PLATFORM"/*/; do
    name=$(basename "$dir")
    link_config "$dir" "$HOME/.config/$name"
  done
fi

echo ""
echo "Done! All configs symlinked."
