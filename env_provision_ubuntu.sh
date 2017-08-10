#!/usr/bin/env bash

#Update the OS at start
sudo apt-get update
sudo apt-get upgrade -y

#Configure Puppet repos
wget https://apt.puppetlabs.com/puppet-release-xenial.deb
sudo dpkg -i puppetlabs-release-precise.deb
sudo apt-get update

#Install Puppet requirements
sudo apt-get install ruby ruby-dev -y

#Install Puppet
sudo apt-get install puppet

# Copy repo into place
sudo rm -rf /etc/puppetlabs/code
git clone git@github.com:absie01/puppet.git /etc/puppetlabs/code    #This requires an SSH key on an authorised account



