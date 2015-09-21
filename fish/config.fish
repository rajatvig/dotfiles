eval (direnv hook fish)

set brew_rbenv "/usr/local/var/rbenv/shims"

set -gx RBENV_ROOT /usr/local/var/rbenv

set -gx PYENV_ROOT /usr/local/var/pyenv

set -gx GOPATH /usr/local/var/go

set -gx PATH /usr/local/sbin $PATH $GOPATH/bin

# eval sh $HOME/.config/base16-shell/base16-default.dark.sh
