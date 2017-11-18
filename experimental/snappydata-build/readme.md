# How to install

This was tested on Windows 10

Install:

* __Install Vagrant 1.8.4+__ https://www.vagrantup.com/downloads.html
* Install VirtualBox https://www.virtualbox.org/wiki/Downloads
* `vagrant plugin install vagrant-vbguest`
* `vagrant up`
* `vagrant provision`

Point your sql client to `snappydata.192.168.55.4.nip.io`.

## Notes

The YCSB SnappyStore driver hard codes the hostname. Patches are accepted to fix this.

```
vagrant ssh
# Password: vagrant
sudo su - snappydata-ycsb
cd ~/src
./bin/ycsb load snappystore -P workloads/workloada -s -threads 8 -p recordcount=1000000
./bin/ycsb run snappystore -P workloads/workloada -s -threads 8 -p operationcount=1000000 -p requestdistribution=zipfian
```

On server restart set Zookeeper replicas to 1 and wait for stability. Then increase to 3 replicas.
