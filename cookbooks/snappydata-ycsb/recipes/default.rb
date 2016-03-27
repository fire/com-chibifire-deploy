#
# Cookbook Name:: snappydata-ycsb
# Recipe:: default
#
# Copyright (C) 2016 K. S. Ernest (iFire) Lee
#
# All rights reserved - Do Not Redistribute
#

git '/home/vagrant/YCSB' do
  repository 'https://github.com/brianfrankcooper/YCSB.git'
  revision 'f25f26f5e80cc417bae4b61fa7c1a4d963ce96b4'
  action :sync
  enable_submodules true
  user 'vagrant'
  group 'vagrant'
  timeout 3600
end

cookbook_file "/home/vagrant/YCSB/ycsb-0.8.0-SNAPSHOT-snappystore-01.patch" do
  source "ycsb-0.8.0-SNAPSHOT-snappystore-01.patch"
  owner "vagrant"
  group "vagrant"
  mode 00755
  action :create
end

package 'dos2unix' do
  action :upgrade
end

execute "dos2unix-snappydata-ycsb-patch" do
  command "dos2unix /home/vagrant/YCSB/ycsb-0.8.0-SNAPSHOT-snappystore-01.patch"
  user 'vagrant'
  group 'vagrant'
  cwd '/home/vagrant/YCSB'
end

bash "apply-snappydata-ycsb-patch" do
  code <<-EOH
     git apply /home/vagrant/YCSB/ycsb-0.8.0-SNAPSHOT-snappystore-01.patch
  EOH
  user 'vagrant'
  group 'vagrant'
  cwd '/home/vagrant/YCSB'
end

package 'maven' do
  action :upgrade
end

bash "compile-ycsb" do
  code <<-EOH
    "mvn -pl com.yahoo.ycsb:snappystore-binding -am clean package"
  EOH
  user 'vagrant'
  group 'vagrant'
  cwd '/home/vagrant/YCSB'
end

execute "create-ycsb-tables" do
  command "ls"
  user 'vagrant'
  group 'vagrant'
  cwd '/home/vagrant/YCSB'
end

execute "load-ycsb" do
  command "./bin/ycsb load snappystore -P workloads/workloada -s -threads 4 -p recordcount=500000"
  user 'vagrant'
  group 'vagrant'
  cwd '/home/vagrant/YCSB'
end

execute "load-ycsb" do
  command "./bin/ycsb run snappystore -P workloads/workloada -s -threads 4 -p operationcount=500000 -p requestdistribution=zipfian"
  user 'vagrant'
  group 'vagrant'
  cwd '/home/vagrant/YCSB'
end
