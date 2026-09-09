#!/usr/bin/env bash

set -euo pipefail

if command -v fish >/dev/null 2>&1; then
  mkdir -p ~/.config/fish

  ln -sfn "$DOTFILES_DIR/fish/config.fish" ~/.config/fish/config.fish

  fish -c '
if not functions -q fisher
  curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish \
    | source
end

fisher install jorgebucaran/fisher
fisher install patrickf1/fzf.fish
fisher install budimanjojo/tmux.fish
fisher install ilancosman/tide@v6
'

fi
