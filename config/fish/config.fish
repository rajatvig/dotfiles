direnv hook fish | source
opam config env | source
thefuck --alias | source

set brew_rbenv "/usr/local/var/rbenv/shims"

set -gx EDITOR vim
set -gx GIT_EDITOR vim
set -gx RBENV_ROOT /usr/local/var/rbenv
set -gx PYENV_ROOT /usr/local/var/pyenv
set -gx GOPATH /usr/local/var/go
set -gx NVM_DIR /usr/local/var/nvm

set -gx DOCKER_USER rajatvig

set -gx RUST_SRC_PATH $HOME/.multirust/toolchains/stable-x86_64-apple-darwin/lib/rustlib/src/rust/src

set -g fish_user_paths $HOME/.cabal/bin $fish_user_paths
set -g fish_user_paths $HOME/.cargo/bin $fish_user_paths
set -g fish_user_paths "/usr/local/sbin" $fish_user_paths

set tacklebox_path  ~/.config/fish_plugins/z ~/.config/fish_plugins/tackle ~/.config/fish_plugins/to ~/.config/fish_plugins/brew ~/.config/fish_plugins/pyenv ~/.config/fish_plugins/git
set tacklebox_modules virtualfish z
set tacklebox_plugins docker extract grc pip python

# set tacklebox_theme budspencer

source ~/.config/fish_plugins/tacklebox/tacklebox.fish
