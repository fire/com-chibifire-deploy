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
    cd /home/vagrant/YCSB
    if [ ! -d /home/vagrant/YCSB/snappystore ]; then
      git apply ycsb-0.8.0-SNAPSHOT-snappystore-01.patch
    fi
  EOH
  user 'vagrant'
  group 'vagrant'
end

package 'maven' do
  action :upgrade
end

bash "compile-ycsb" do
  code <<-EOH
    cd /home/vagrant/YCSB
    mvn -pl com.yahoo.ycsb:snappystore-binding -am clean package
  EOH
  user 'vagrant'
  group 'vagrant'
end

execute "create-ycsb-tables" do
  command "ls"
  user 'vagrant'
  group 'vagrant'
  cwd '/home/vagrant/YCSB'
end

execute "load-ycsb" do
  command "./bin/ycsb load snappystore -P workloads/workloada -s -threads 4 -p recordcount=50000"
  user 'vagrant'
  group 'vagrant'
  cwd '/home/vagrant/YCSB'
end

execute "run-ycsb" do
  command "./bin/ycsb run snappystore -P workloads/workloada -s -threads 4 -p operationcount=50000 -p requestdistribution=zipfian"
  user 'vagrant'
  group 'vagrant'
  cwd '/home/vagrant/YCSB'
end
