#!/bin/sh

set -x
set -e

cd $(dirname $0)

VER=$1

if [ ! -s $HOME/.rvm/scripts/rvm ]; then
  curl -sSL https://get.rvm.io | bash
fi

source $HOME/.rvm/scripts/rvm
rvm install $VER
rvm use $VER --default
