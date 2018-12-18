#!/usr/bin/env fish

set -l asdf_dir ~/.asdf
set -g fish_user_paths $asdf_dir/bin $fish_user_paths
set -g fish_user_paths $asdf_dir/shims $fish_user_paths
