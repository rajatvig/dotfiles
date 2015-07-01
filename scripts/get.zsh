#!/usr/bin/env sh

sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

ln -s ~/dotfiles/config/zshrc .zshrc
