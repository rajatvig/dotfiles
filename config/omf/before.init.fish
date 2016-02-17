eval (direnv hook fish)

set brew_rbenv "/usr/local/var/rbenv/shims"

set -gx RBENV_ROOT /usr/local/var/rbenv
set -gx PYENV_ROOT /usr/local/var/pyenv
set -gx NVM_DIR /usr/local/var/nvm
set -gx GOPATH /usr/local/var/go

set -gx RUST_SRC_PATH $HOME/work/oss/rust/rust/src
set -gx PATH $PATH $HOME/.cabal/bin $HOME/.multirust/toolchains/beta/cargo/bin

# OPAM configuration
. $HOME/.opam/opam-init/init.fish > /dev/null 2> /dev/null or true
