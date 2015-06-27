#!/usr/bin/env sh

git clone --recursive https://github.com/syl20bnr/spacemacs ~/.emacs.d
ln -s dotfiles/spacemacs .spacemacs

npm install -g tern
npm install -g js-beautify
