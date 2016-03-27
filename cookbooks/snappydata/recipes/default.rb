#
# Cookbook Name:: snappydata
# Recipe:: default
#
# Copyright (C) 2016 K. S. Ernest (iFire) Lee
#
# All rights reserved - Do Not Redistribute
#

git '/home/vagrant/snappydata' do
  repository 'https://github.com/SnappyDataInc/snappydata.git'
  revision 'v0.2.1-preview'
  action :sync
  enable_submodules true
  user 'vagrant'
  group 'vagrant'
  timeout 3600
end

# https://unix.stackexchange.com/questions/69314/automated-ssh-keygen-without-passphrase-how

execute 'generate_ssh_key' do
  command 'cat /dev/zero | ssh-keygen -t rsa -q -N ""'
  user 'vagrant'
  group 'vagrant'
  action :nothing
end

execute 'add_key_to_authorized' do
  command 'cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys'
  user 'vagrant'
  group 'vagrant'
  action :nothing
end

execute 'set_git_username_and_email' do
  command 'git config --global user.email "vagrant@snappydata.example.com" && git config --global user.name "Snappydata Vagrant"'
  user 'vagrant'
  group 'vagrant'
  action :nothing
end

file '/home/vagrant/.ssh_key.lock' do
  action :create_if_missing
  notifies :run, 'execute[generate_ssh_key]', :immediately
  notifies :run, 'execute[add_key_to_authorized]', :immediately
  notifies :run, 'execute[set_git_username_and_email]', :immediately
  user 'vagrant'
  group 'vagrant'
end

execute 'gradle_build_product' do
  command '/home/vagrant/snappydata/gradlew product'
  cwd '/vagrant/snappydata'
  user 'vagrant'
  group 'vagrant'
end

execute 'start_snappydata_server' do
  command '/home/vagrant/snappydata/sbin/snappy-start-all.sh'
  user 'vagrant'
  group 'vagrant'
end
