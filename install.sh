#!/bin/bash

# This runs as root on the server

source ~/.bash_profile

chef_binary=/usr/bin/chef-client

# Are we on a vanilla system?
if ! test -f "$chef_binary"; then
    export DEBIAN_FRONTEND=noninteractive
    # Upgrade headlessly (this is only safe-ish on vanilla systems)
    echo "Updating aptitude repositories"
    sudo apt-get update

    echo "About to install curl"
    sudo apt-get install -y curl

    echo "About to install chef"
    curl -L https://www.opscode.com/chef/install.sh | sudo bash

    if [ $? -eq 0 ]; then
        echo "Chef install finished successfully"
    else
        echo "There was an error installing chef-client"
    fi
else
    echo "Chef client is already installed on this server"
fi

