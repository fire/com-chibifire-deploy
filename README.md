# What is SnappyData?

https://github.com/SnappyDataInc/snappydata

SnappyData is a **distributed in-memory data store for real-time operational analytics, delivering stream analytics, OLTP (online transaction processing) and OLAP (online analytical processing) in a single integrated cluster**. We realize this platform through a seamless integration of Apache Spark (as a big data computational engine) with GemFire XD (as an in-memory transactional store with scale-out SQL semantics).

## How to install

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

## Docker start commands

Copy the snappydata kubebernetes configuration and execute the yaml.

To reinitalize, delete all the workers.

```
kubectl delete pods,services,petsets,pvc -l app=snappydata-locator
kubectl delete pods,services,petsets,pvc -l app=snappydata-server
kubectl delete pods,services,petsets,pvc -l app=snappydata-leader 
kubectl delete pods,services,petsets,pvc -l app=snappydata
kubectl create -f .\snappydata-petset.yaml
```

Start a snappydata client.

```
kubectl run snappydata-client -it --image=snappydatainc/snappydata  --rm --restart=Never /bin/bash
/opt/snappydata/bin/snappy-shell
connect client 'snappydata-locator-0:1527';
connect client 'snappydata-locator-1:1527';
select id, kind, status, host, port from sys.members;
```

Proxy spark ui.

```
kubectl port-forward snappydata-server-0 1527
kubectl port-forward snappydata-leader-0 4040
```