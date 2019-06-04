#!/usr/bin/env fish

function kshell
    kubectl run my-shell --rm -i --tty --image gcr.io/etsy-gcr-prod/curl:master-51-7fc9d251e3 -- sh
end
