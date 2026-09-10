#!/usr/bin/env bash

set -euo pipefail

# install_gcm() {
#   if grep -qi microsoft /proc/version 2>/dev/null; then
#     GCM="/mnt/c/Program Files/Git/mingw64/bin/git-credential-manager.exe"
#
#     if [[ ! -x "$GCM" ]]; then
#       winget.exe install \
#         --id Git.Git \
#         --exact \
#         --silent \
#         --accept-package-agreements \
#         --accept-source-agreements
#     fi
#
#     if [[ ! -x "$GCM" ]]; then
#       echo "Git Credential Manager was not found" >&2
#     fi
#   fi
# }
#
# case "$(uname -s)" in
# Darwin)
#   ln -sfn "$DOTFILES/git/gitconfig.mac" "$HOME/.gitconfig.local"
#   ;;
# Linux)
#   if grep -qi microsoft /proc/version 2>/dev/null; then
#     install_gcm
#     ln -sfn "$DOTFILES/git/gitconfig.wsl" "$HOME/.gitconfig.local"
#   else
#     ln -sfn "$DOTFILES/git/gitconfig.linux" "$HOME/.gitconfig.local"
#   fi
#   ;;
# esac

cat "$DOTFILES/git/gitconfig" >"$HOME/.gitconfig"

# GitHub
if ! gh auth status >/dev/null 2>&1; then
  gh auth login --git-protocol https
fi

gh auth setup-git
