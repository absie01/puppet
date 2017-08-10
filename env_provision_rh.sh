#!/usr/bin/env bash

# A simple script to provision the server pre-Puppet

# Ensure machine is updated and install some utils
sudo yum update -y
sudo yum install ruby -y

# Add Puppet repo and install puppet-agent
sudo rpm -ivh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm
sudo yum install puppet-agent -y

# Install librarian-puppet gem for module management
sudo gem install librarian-puppet

# Copy repo into place
sudo rm -rf /etc/puppetlabs/code
git clone git@github.com:absie01/puppet.git /etc/puppetlabs/code    #This requires an SSH key on an authorised account

# Apply Puppet Manifest
sudo /opt/puppetlabs/bin/puppet apply /etc/puppetlabs/code/manifests/site.pp

# Add cron to keep server updated via Puppet
line="*/15 * * * * /etc/puppetlabs/code/git_cron.sh"
(crontab -u sdes-dev -l; echo "$line" ) | crontab -u sdes-dev -