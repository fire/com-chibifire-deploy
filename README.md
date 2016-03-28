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
* Must manually patch https://github.com/mitchellh/vagrant/commit/0505771481222b4893daa5454ff6c9c16f471fa4 to avoid bug with private networks.
* Install VirtualBox https://www.virtualbox.org/wiki/Downloads
* `vagrant plugin install vagrant-berkshelf`
* `vagrant plugin install vagrant-vbguest`
* `vagrant up`
* `vagrant provision`

Point your sql client to `ubuntu-xenial.192.168.55.4.xip.io`.

## Notes

The YCSB SnappyStore driver hard codes the hostname. Patches accepted for this.
