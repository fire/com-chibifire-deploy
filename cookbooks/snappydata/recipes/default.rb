#
# Cookbook Name:: snappydata
# Recipe:: default
#
# Copyright (C) 2016 K. S. Ernest (iFire) Lee
#
# All rights reserved - Do Not Redistribute
#

git '/home/' + node['snappydata']['user'] + '/snappydata' do
  repository 'https://github.com/SnappyDataInc/snappydata.git'
  revision 'v0.3-preview'
  action :sync
  enable_submodules true
  user node['snappydata']['user']
  group node['snappydata']['group']
  timeout 3600
end

# https://unix.stackexchange.com/questions/69314/automated-ssh-keygen-without-passphrase-how

execute 'generate_ssh_key' do
  command 'cat /dev/zero | ssh-keygen -t rsa -q -N ""'
  user node['snappydata']['user']
  group node['snappydata']['group']
  action :nothing
end

execute 'add_key_to_authorized' do
  command 'cat /home/' + node['snappydata']['user'] + '/.ssh/id_rsa.pub >> /home/'+ node['snappydata']['user'] + '/.ssh/authorized_keys'
  user node['snappydata']['user']
  group node['snappydata']['group']
  action :nothing
end

execute 'set_git_username_and_email' do
  command 'git config --global user.email "vagrant@snappydata.example.com" && git config --global user.name "Snappydata Vagrant"'
  user node['snappydata']['user']
  group node['snappydata']['group']
  action :nothing
  environment 'HOME' => '/home/' + node['snappydata']['user']
end

file '/home/' + node['snappydata']['user'] + '/.ssh_key_git_config.lock' do
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
  notifies :reload, "service[snappydata]"
end

service "snappydata" do
  provider Chef::Provider::Service::Systemd
  supports :restart => true
  action [:enable,:stop]
end

execute 'gradle_build_product' do
  command '/home/' + node['snappydata']['user'] + '/snappydata/gradlew product'
  cwd '/home/' + node['snappydata']['user'] + '/snappydata'
  user node['snappydata']['user']
  group node['snappydata']['group']
end

template '/home/' + node['snappydata']['user'] + '/snappydata/build-artifacts/scala-2.10/snappy/conf/leads' do
  source "leads.erb"
  owner node['snappydata']['user']
  group node['snappydata']['group']
  mode 00644
end


template '/home/' + node['snappydata']['user'] + '/snappydata/build-artifacts/scala-2.10/snappy/conf/servers' do
  source "servers.erb"
  owner node['snappydata']['user']
  group node['snappydata']['group']
  mode 00644
end

template '/home/' + node['snappydata']['user'] + '/snappydata/build-artifacts/scala-2.10/snappy/conf/locators' do
  source "locators.erb"
  owner node['snappydata']['user']
  group node['snappydata']['group']
  mode 00644
end

template '/etc/hosts' do
  source "hosts.erb"
  owner 'root'
  group 'root'
  mode 00644
end

execute 'write_hostname' do
  command 'sudo hostnamectl set-hostname ' + node['snappydata']['hostname']
  user 'root'
  group 'root'
end

service "snappydata" do
  provider Chef::Provider::Service::Systemd
  supports :restart => true
  supports :status => true
  action [ :enable, :start ]
end

execute 'enable_snappydata' do
  command 'systemctl enable snappydata'
  user 'root'
  group 'root'
end

include_recipe 'snappydata-ycsb::default'
