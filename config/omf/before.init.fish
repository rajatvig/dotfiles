eval (direnv hook fish)
eval (opam config env)

set brew_rbenv "/usr/local/var/rbenv/shims"

set -gc EDITOR mvim
set -gx RBENV_ROOT /usr/local/var/rbenv
set -gx PYENV_ROOT /usr/local/var/pyenv
set -gx GOPATH /usr/local/var/go
set -gx NVM_DIR /usr/local/var/nvm

set -gx DOCKER_USER rajatvig

set -gx RUST_SRC_PATH $HOME/.multirust/toolchains/stable-x86_64-apple-darwin/lib/rustlib/src/rust/src
set -gx PATH $PATH $HOME/.cabal/bin $HOME/.cargo/bin
