#
# Cookbook Name:: main
# Recipe:: default
#
# Copyright (C) 2016 K. S. Ernest (iFire) Lee
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'apt-upgrade-once::default'

package 'openjdk-8-jdk' do
  action :upgrade
end

package 'git' do
  action :upgrade
end

package 'openssh-server' do
  action :upgrade
end

include_recipe 'snappydata::default'
