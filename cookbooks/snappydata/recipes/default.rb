#
# Cookbook Name:: snappydata
# Recipe:: default
#
# Copyright (C) 2016 K. S. Ernest (iFire) Lee
#
# All rights reserved - Do Not Redistribute
#

package 'openjdk-8-jdk' do
  action :upgrade
end

package 'git' do
  action :upgrade
end

package 'openssh-server' do
  action :upgrade
end

user node['snappydata']['user'] do
  supports :manage_home => true
  comment 'User ' + node['snappydata']['user']
  home node['snappydata']['home_dir']
  shell '/bin/bash'
  system true
  action :create
end

git node['snappydata']['dir'] do
  repository 'https://github.com/SnappyDataInc/snappydata.git'
  revision '56ecf8e6b4acad07155f5b6aa5daf455909fdcb9'
  action :sync
  enable_submodules true
  user node['snappydata']['user']
  group node['snappydata']['group']
  timeout 3600
end

# https://unix.stackexchange.com/questions/69314/automated-ssh-keygen-without-passphrase-how

directory node['snappydata']['home_dir'] + '/.ssh/' do
  mode '0700'
  owner  node['snappydata']['user']
  group node['snappydata']['group']
end

file node['snappydata']['home_dir'] + '/.ssh/authorized_keys' do
  mode '0644'
  owner  node['snappydata']['user']
  group node['snappydata']['group']
  action :touch
end

execute 'generate_ssh_key' do
  command 'cat /dev/zero | ssh-keygen -t rsa -q -N ""'
  user node['snappydata']['user']
  group node['snappydata']['group']
  action :nothing
end

execute 'add_key_to_authorized' do
  command 'cat ' + node['snappydata']['home_dir'] + '/.ssh/id_rsa.pub >> '+ node['snappydata']['home_dir'] + '/.ssh/authorized_keys'
  user node['snappydata']['user']
  group node['snappydata']['group']
  action :nothing
end

execute 'set_git_username_and_email' do
  command 'git config --global user.email "vagrant@snappydata.example.com" && git config --global user.name "Snappydata Vagrant"'
  user node['snappydata']['user']
  group node['snappydata']['group']
  action :nothing
  environment 'HOME' => node['snappydata']['home_dir']
end

file node['snappydata']['home_dir'] + '/.ssh_key_git_config.lock' do
  action :create_if_missing
  notifies :run, 'execute[generate_ssh_key]', :immediate
  notifies :run, 'execute[add_key_to_authorized]', :immediate
  notifies :run, 'execute[set_git_username_and_email]', :immediate
  user node['snappydata']['user']
  group node['snappydata']['group']
end

template "/etc/systemd/system/snappydata.service" do
  source "snappydata.service.erb"
  owner "root"
  group "root"
  mode 00644
end

execute 'gradle_build_product' do
  command './gradlew product'
  cwd node['snappydata']['dir']
  user node['snappydata']['user']
  group node['snappydata']['group']
end

template node['snappydata']['dir'] + '/build-artifacts/scala-2.10/snappy/conf/leads' do
  source "leads.erb"
  owner node['snappydata']['user']
  group node['snappydata']['group']
  mode 00644
end

service "snappydata" do
  action [ :enable, :stop ]
end

template node['snappydata']['dir'] + '/build-artifacts/scala-2.10/snappy/conf/servers' do
  source "servers.erb"
  owner node['snappydata']['user']
  group node['snappydata']['group']
  mode 00644
end

template node['snappydata']['dir'] + '/build-artifacts/scala-2.10/snappy/conf/locators' do
  source "locators.erb"
  owner node['snappydata']['user']
  group node['snappydata']['group']
  mode 00644
end

hostsfile_entry node['snappydata']['ip'] do
  hostname  node['snappydata']['hostname']
  action    :create_if_missing
end

hostsfile_entry '192.168.50.51' do
  hostname  'broker1'
  action    :create_if_missing
end

hostsfile_entry '192.168.50.52' do
  hostname  'broker2'
  action    :create_if_missing
end

hostsfile_entry '192.168.50.53' do
  hostname  'broker3'
  action    :create_if_missing
end

hostsfile_entry '192.168.50.11' do
  hostname  'zk1'
  action    :create_if_missing
end

execute 'write_hostname' do
  command 'sudo hostnamectl set-hostname ' + node['snappydata']['hostname']
  user 'root'
  group 'root'
end

service "snappydata" do
  action :start
end
