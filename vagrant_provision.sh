#!/usr/bin/env bash

# A simple script to provision the Vagrant dev env

# Ensure machine is updated and install some utils
sudo yum update -y
sudo yum install ruby -y
sudo yum install vim -y
sudo yum install mlocate -y

# Add Puppet repo and install puppet-agent
sudo rpm -ivh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm
sudo yum install puppet-agent -y

# Install librarian-puppet gem for module management
sudo gem install librarian-puppet

# Copy repo into place
sudo rm -rf /etc/puppetlabs/code
sudo cp -rf /vagrant /etc/puppetlabs/code

# Apply Puppet Manifest
sudo /opt/puppetlabs/bin/puppet apply /etc/puppetlabs/code/manifests/site.pp

# Run updatedb in background
sudo updatedb &