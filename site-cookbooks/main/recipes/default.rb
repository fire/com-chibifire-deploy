#
# Cookbook Name:: main
# Recipe:: default
#
# Copyright (C) 2016 K. S. Ernest (iFire) Lee
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'snappydata::default'
include_recipe 'apt-upgrade-once::default'
