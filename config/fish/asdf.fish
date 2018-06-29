set -l asdf_dir /usr/local/opt/asdf

# we get an ugly warning when setting the path if shims does not exist
mkdir -p $asdf_dir/shims

if not contains $asdf_dir/{bin,shims} $PATH
    and test -d $asdf/{bin,shims}
    set -gx PATH $asdf_dir/{bin,shims} $PATH
end
