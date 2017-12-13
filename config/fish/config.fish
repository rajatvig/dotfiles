direnv hook fish | source
thefuck --alias | source

set -gx EDITOR vim
set -gx GIT_EDITOR vim
set -gx GOPATH /usr/local/var/go

set -g fish_user_paths /usr/local/bin $fish_user_paths
set -g fish_user_paths /usr/local/sbin $fish_user_paths
set -g fish_user_paths $HOME/Library/Haskell/bin $fish_user_paths
set -g fish_user_paths /usr/local/opt/coreutils/libexec/gnubin $fish_user_paths

set tacklebox_path  ~/.config/fish_plugins/z ~/.config/fish_plugins/tackle ~/.config/fish_plugins/to ~/.config/fish_plugins/brew ~/.config/fish_plugins/pyenv ~/.config/fish_plugins/git
set tacklebox_modules z
set tacklebox_plugins docker extract grc docker

source ~/.config/fish_plugins/tacklebox/tacklebox.fish

source /usr/local/opt/asdf/asdf.fish

opam config env | source

set -xg PATH (yarn global bin) $PATH
set -xg PATH /usr/local/opt/asdf/installs/ruby/(asdf list ruby|head -n 1)/bin $PATH

source ~/.config/fish/private.fish
