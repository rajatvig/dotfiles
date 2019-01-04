#!/usr/bin/env fish

function v --description='edit file vim'
  find . -type f | fzf -q $argv | read -l result; and nvim $result
end
