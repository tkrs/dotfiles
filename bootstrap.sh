#!/usr/bin/env bash

set -euo pipefail

export DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

NO_ADMIN=false
NO_BREW=false

for arg in "$@"; do
  case "$arg" in
  --no-admin) NO_ADMIN=true ;;
  --no-brew) NO_BREW=true ;;
  esac
done

install_brew() {
  if command -v brew >/dev/null 2>&1; then
    return
  fi

  case "$(uname -s)" in
  Linux)
    sudo apt-get update
    sudo apt-get install -y build-essential procps curl file git
    ;;
  Darwin) ;;
  *)
    echo "Unsupported OS: $(uname -s)" >&2
    exit 1
    ;;
  esac

  NONINTERACTIVE=1 /bin/bash -c \
    "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  if [[ -x /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [[ -x /home/linuxbrew/.linuxbrew/bin/brew ]]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  else
    echo "Homebrew installation failed" >&2
    exit 1
  fi
}

install_brew_no_admin() {
  local prefix="$HOME/.homebrew"

  if [[ ! -x "$prefix/bin/brew" ]]; then
    mkdir -p "$prefix"

    curl -fsSL https://github.com/Homebrew/brew/tarball/main |
      tar xz --strip-components=1 -C "$prefix"
  fi

  eval "$("$prefix/bin/brew" shellenv)"
}

if [[ "$NO_BREW" == "false" ]]; then
  if [[ "$NO_ADMIN" == "false" ]]; then
    install_brew
  else
    install_brew_no_admin
  fi

  brew bundle --file="$DOTFILES_DIR/Brewfile"
fi

"$DOTFILES_DIR/scripts/setup_git.sh"
"$DOTFILES_DIR/scripts/setup_mise.sh"
"$DOTFILES_DIR/scripts/setup_fish.sh"
"$DOTFILES_DIR/scripts/setup_tmux.sh"
