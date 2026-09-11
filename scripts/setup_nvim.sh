#!/usr/bin/env bash

set -euo pipefail

if command -v nvim >/dev/null 2>&1; then
  find "$DOTFILES_DIR/config/nvim" -name '*.lua' | while IFS= read -r source_file; do
    dest_file="${source_file//$DOTFILES_DIR\/config/$HOME\/.config}"
    mkdir -p "$(dirname "$dest_file")"
    ln -sfn "$source_file" "$dest_file"
  done
fi
