#!/usr/bin/env bash

set -euo pipefail

if [ ! -d "$HOME/.tmux" ]; then
  git clone https://github.com/gpakosz/.tmux.git "$HOME/.tmux"
fi

ln -sfn "$HOME/.tmux/.tmux.conf" "$HOME/.tmux.conf"
ln -sfn "$DOTFILES_DIR/config/tmux/tmux.conf.local" "$HOME/.tmux.conf.local"
