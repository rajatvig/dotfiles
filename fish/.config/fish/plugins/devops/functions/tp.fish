#!/usr/bin/env fish

function tp
    terraform plan -out tfplan
end
