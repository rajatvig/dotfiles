#!/usr/bin/env fish

function gssh
    gcloud compute ssh $argv --internal-ip --project=etsy-web-prod
end
