# Vagrant repository of Snappydata

Use this for testing of SnappyData.

## What is SnappyData?

https://github.com/SnappyDataInc/snappydata

SnappyData is a **distributed in-memory data store for real-time operational analytics, delivering stream analytics, OLTP (online transaction processing) and OLAP (online analytical processing) in a single integrated cluster**. We realize this platform through a seamless integration of Apache Spark (as a big data computational engine) with GemFire XD (as an in-memory transactional store with scale-out SQL semantics).

## How to install

This was tested on Windows 10

Install:

* ChefDK https://downloads.chef.io/chef-dk
* Vagrant https://www.vagrantup.com/downloads.html
* `vagrant plugin install vagrant-berkshelf`
* `vagrant up`

Point your sql client to `vagrant-ubuntu-trusty-64.192.168.55.4.xip.io`.
