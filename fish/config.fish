eval (direnv hook fish)

set brew_rbenv "/usr/local/var/rbenv/shims"

set -gx RBENV_ROOT /usr/local/var/rbenv
set -gx PYENV_ROOT /usr/local/var/pyenv
set -gx NVM_DIR /usr/local/var/nvm
set -gx GOPATH /usr/local/var/go
set -gx RUST_SRC_PATH $HOME/work/private/tryouts/rust/rust/src
set -gx PATH /usr/local/sbin $PATH $GOPATH/bin $HOME/.multirust/toolchains/beta/cargo/bin

fundle plugin 'tuvistavie/fish-theme-afowler'
fundle plugin 'tuvistavie/oh-my-fish-core'
fundle plugin 'tuvistavie/fish-completion-helpers'
fundle plugin 'tuvistavie/fish-fastdir'

fundle plugin 'joehillen/to-fish'

fundle plugin 'oh-my-fish/plugin-rbenv'
fundle plugin 'oh-my-fish/plugin-foreign-env'
fundle plugin 'derekstavis/plugin-nvm'

fundle plugin 'edc/bass'

fundle plugin 'rajatvig/fish-pyenv'

fundle init
