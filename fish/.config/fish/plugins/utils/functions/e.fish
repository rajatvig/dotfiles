function e --description='edit file'
  find . -type f | fzf -q $argv | read -l result; and emacsclient -c -n $result
end
