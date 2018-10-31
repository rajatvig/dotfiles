direnv hook fish | source

set -gx EDITOR nvim
set -gx GIT_EDITOR nvim
set -gx GOPATH /usr/local/var/go
set -gx ASDF_DIR ~/.asdf

set -g fish_user_paths /usr/local/bin $fish_user_paths
set -g fish_user_paths /usr/local/sbin $fish_user_paths
set -g fish_user_paths /usr/local/opt/gettext/bin $fish_user_paths
set -g fish_user_paths /usr/local/opt/coreutils/libexec/gnubin $fish_user_paths

set -g fish_user_paths $GOPATH/bin $fish_user_paths

set tacklebox_path ~/.config/fish_plugins/pure ~/.config/fish_plugins/z ~/.config/fish_plugins/tackle ~/.config/fish_plugins/to ~/.config/fish_plugins/brew ~/.config/fish_plugins/git ~/.config/fish_plugins/docker
set tacklebox_modules z
set tacklebox_plugins docker extract grc

source ~/.config/fish_plugins/tacklebox/tacklebox.fish

for f in asdf autotmux private
    source ~/.config/fish/$f.fish
end
