#!/usr/bin/env bash

set -euo pipefail

if command -v nvim >/dev/null 2>&1; then
  mapfile -t source_files < <(find "$DOTFILES_DIR/nvim" -name "*.lua")

  for source_file in "${source_files[@]}"; do
    local dest_file="${source_file//$DOTFILES_DIR/$HOME\/.config}"
    mkdir -p "$(dirname "$dest_file")"
    ln -sfn "$source_file" "$dest_file"
  done
fi
