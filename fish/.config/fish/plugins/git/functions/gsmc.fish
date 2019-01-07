#!/usr/bin/env fish

function gsmc --description 'reset submodules to HEAD'
    git submodule foreach git checkout .
    git submodule foreach git fetch --all
    git submodule foreach git pull --rebase
    git submodule foreach git checkout master
end
