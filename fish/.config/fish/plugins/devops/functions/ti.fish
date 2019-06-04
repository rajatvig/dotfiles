#!/usr/bin/env fish

function ti
    terraform init --backend-config=backend.conf
end
