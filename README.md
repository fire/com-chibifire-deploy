# What is SnappyData?

https://github.com/SnappyDataInc/snappydata

SnappyData is a **distributed in-memory data store for real-time operational analytics, delivering stream analytics, OLTP (online transaction processing) and OLAP (online analytical processing) in a single integrated cluster**. We realize this platform through a seamless integration of Apache Spark (as a big data computational engine) with GemFire XD (as an in-memory transactional store with scale-out SQL semantics).

## How to install

This was tested on Windows 10

Install:

* Vagrant https://www.vagrantup.com/downloads.html
* Install VirtualBox https://www.virtualbox.org/wiki/Downloads
* `vagrant plugin install vagrant-vbguest`
* `vagrant up`
* `vagrant provision`

Point your sql client to `snappydata.192.168.55.4.xip.io`.

## Notes

The YCSB SnappyStore driver hard codes the hostname. Patches are accepted to fix this.

```
./bin/ycsb load snappystore -P workloads/workloada -s -threads 36 -p recordcount=2000000
./bin/ycsb run snappystore -P workloads/workloada -s -threads 36 -p operationcount=500000 -p requestdistribution=zipfian
```
