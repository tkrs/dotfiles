#!/usr/bin/env bash

set -euo pipefail

if command -v mise >/dev/null 2>&1; then
  mkdir -p "$HOME/.config/mise"

  ln -sfn "$DOTFILES_DIR/config/mise/config.toml" "$HOME/.config/mise/config.toml"

  mise install
fi
