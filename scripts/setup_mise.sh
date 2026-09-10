#!/usr/bin/env bash

set -euo pipefail

if command -v mise >/dev/null 2>&1; then
  ln -sfn "$DOTFILES_DIR/mise/config.toml" ~/.config/mise/config.toml

  mise install
fi
