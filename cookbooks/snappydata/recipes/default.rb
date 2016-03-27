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
  command 'cat /home/vagrant/.ssh/id_rsa.pub >> /home/vagrant/.ssh/authorized_keys'
  user 'vagrant'
  group 'vagrant'
  action :nothing
end

execute 'set_git_username_and_email' do
  command 'git config --global user.email "vagrant@snappydata.example.com" && git config --global user.name "Snappydata Vagrant"'
  user 'vagrant'
  group 'vagrant'
  action :nothing
  environment 'HOME' => '/home/vagrant'
end

file '/home/vagrant/.ssh_key.lock' do
  action :create_if_missing
  notifies :run, 'execute[generate_ssh_key]', :immediate
  notifies :run, 'execute[add_key_to_authorized]', :immediate
  notifies :run, 'execute[set_git_username_and_email]', :immediate
  user 'vagrant'
  group 'vagrant'
end

execute 'gradle_build_product' do
  command '/home/vagrant/snappydata/gradlew product'
  cwd '/home/vagrant/snappydata'
  user 'vagrant'
  group 'vagrant'
end

cookbook_file "/etc/init/snappydata.conf" do
  source "snappydata.conf"
  owner "root"
  group "root"
  mode 00644
  action :create
end

cookbook_file "/home/vagrant/snappydata/build-artifacts/scala-2.10/snappy/conf/servers" do
  source "servers"
  owner "vagrant"
  group "vagrant"
  mode 00755
  action :create
end

cookbook_file "/home/vagrant/snappydata/build-artifacts/scala-2.10/snappy/conf/leads" do
  source "leads"
  owner "vagrant"
  group "vagrant"
  mode 00755
  action :create
end

cookbook_file "/home/vagrant/snappydata/build-artifacts/scala-2.10/snappy/conf/locators" do
  source "locators"
  owner "vagrant"
  group "vagrant"
  mode 00755
  action :create
end

cookbook_file "/etc/hosts" do
  source "hosts"
  owner "root"
  group "root"
  mode 00755
  action :create
end

service "snappydata" do
  provider Chef::Provider::Service::Upstart
  supports :restart => true
  action [:enable,:restart]
end

include_recipe 'snappydata-ycsb::default'
