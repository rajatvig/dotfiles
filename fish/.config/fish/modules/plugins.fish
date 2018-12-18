###
# Helper functions
###

function __plugin_add
    set -l plugin "$argv[1]"
    set -l function_path "$plugin/functions"
    set -l completion_path "$plugin/completions"
    set -l load_file_path "$plugin/init.fish"

    for repository in $fish_plugin_dir[-1..1]
        if test -e $repository/$function_path
            __prepend_path_plugin $repository/$function_path fish_function_path
        end
        if test -e $repository/$completion_path
            __prepend_path_plugin $repository/$completion_path fish_complete_path
        end
        if test -e $repository/$load_file_path
            source $repository/$load_file_path
        end
    end
end

function __prepend_path_plugin --no-scope-shadowing --description \
        'Prepend the given path, if it exists, to the specified path list (defaults to PATH)'
    set -l path "$argv[1]"
    set -l list PATH
    if set -q argv[2]
        set list $argv[2]
    end

    if test -d $path
        # If the path is already in the list, remove it first.
        # Prepending puts it in front, where it belongs
        if set -l idx (contains -i -- $path $$list)
            set -e -- {$list}[$idx]
        end
        set -- $list $path $$list
    end
end

for plugin in $fish_plugins
    __plugin_add $plugin
end
