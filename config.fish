eval (direnv hook fish)

set brew_rbenv "/usr/local/var/rbenv/shims"

set -gx RBENV_ROOT /usr/local/var/rbenv

set -x PATH $brew_rbenv $PATH

rbenv rehash >/dev/null ^&1
