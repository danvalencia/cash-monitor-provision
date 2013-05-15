#!/bin/bash

# This runs as root on the server

source ~/.bash_profile

chef_binary=/usr/bin/chef-solo
rvm_binary=/usr/local/rvm

export DEBIAN_FRONTEND=noninteractive

if ! test -f "$chef_binary"; then
    # Upgrade headlessly (this is only safe-ish on vanilla systems)
    echo "Updating aptitude repositories"
    sudo apt-get update

    echo "About to install curl"
    sudo apt-get install -y curl

    echo "About to install chef"
    sudo true && curl -L https://www.opscode.com/chef/install.sh | sudo bash

    if [ $? -eq 0 ]; then
        echo "Chef install finished successfully"
    else
        echo "There was an error installing chef-client"
    fi
else
    echo "Chef client is already installed on this server"
fi

# if ! test -f "$rvm_binary"; then
#     curl -L https://get.rvm.io | bash -s stable
#     echo "rvm has been installed successfully"

#     source /etc/profile.d/rvm.sh
#     rvm requirements
#     rvm install 1.9.3
#     echo "ruby 1.9.3 has been installed successfully"

#     rvm use 1.9.3 --default
#     rvm rubygems current

#     gem install berkshelf
#     echo "Berkshelf has been installed successfully"
# else
#     echo "rvm is already installed"
# fi

"$chef_binary" -c solo.rb -j solo.json

