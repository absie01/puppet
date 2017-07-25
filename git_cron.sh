#!/usr/bin/env bash

echo "Updating Puppet Manifests"
(
    cd /etc/puppetlabs/code
    git pull
)