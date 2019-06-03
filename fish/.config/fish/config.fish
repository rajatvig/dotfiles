direnv hook fish | source

set -gx EDITOR nvim
set -gx GIT_EDITOR nvim
set -gx GOPATH /usr/local/var/go

set -g fish_user_paths $GOPATH/bin $fish_user_paths

set fish_plugin_dir ~/.config/fish/plugins
set fish_plugins asdf brew devops docker git grc spacefish to utils

for f in autotmux plugins z/z
    source ~/.config/fish/modules/$f.fish
end
