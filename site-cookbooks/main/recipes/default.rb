#
# Cookbook Name:: main
# Recipe:: default
#
# Copyright (C) 2016 K. S. Ernest (iFire) Lee
#
# All rights reserved - Do Not Redistribute
#

#Bugfix https://github.com/mitchellh/vagrant/issues/7155
ifconfig '192.168.55.4' do
  device 'lxcbr0'
end

include_recipe 'apt-upgrade-once::default'

apt_repository 'webupd8team-java' do
  uri          'ppa:webupd8team/java'
  distribution 'xenial'
end

bash 'accept_java_license' do
  code <<-EOH
  echo debconf shared/accepted-oracle-license-v1-1 select true | \
  debconf-set-selections
  echo debconf shared/accepted-oracle-license-v1-1 seen true | \
  debconf-set-selections
  EOH
end

package 'oracle-java8-installer' do
  action :upgrade
end

package 'git' do
  action :upgrade
end

package 'openssh-server' do
  action :upgrade
end

include_recipe 'snappydata::default'
