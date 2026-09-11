#!/usr/bin/env bash

set -euo pipefail

if command -v fish >/dev/null 2>&1; then
  mkdir -p ~/.config/fish
  mkdir -p ~/.config/fish/conf.d
  mkdir -p ~/.config/fish/functions

  ln -sfn "$DOTFILES_DIR/config/fish/config.fish" ~/.config/fish/config.fish
  ln -sfn "$DOTFILES_DIR/config/fish/conf.d/brew.fish" ~/.config/fish/conf.d/brew.fish
  ln -sfn "$DOTFILES_DIR/config/fish/conf.d/cargo.fish" ~/.config/fish/conf.d/cargo.fish
  ln -sfn "$DOTFILES_DIR/config/fish/conf.d/mise.fish" ~/.config/fish/conf.d/mise.fish

  ln -sfn "$DOTFILES_DIR/config/fish/functions/gcd.fish" ~/.config/fish/functions/gcd.fish
  ln -sfn "$DOTFILES_DIR/config/fish/functions/gcloud-config.fish" ~/.config/fish/functions/gcloud-config.fish
  ln -sfn "$DOTFILES_DIR/config/fish/functions/ls.fish" ~/.config/fish/functions/ls.fish

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
