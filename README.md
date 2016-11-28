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

```docker
CMD exec /bin/bash -c "/opt/snappydata/snappydata-0.6.1-bin/bin/snappy-shell locator start -peer-discovery-address=localhost -client-bind-address=localhost -peer-discovery-port=9999 && trap : TERM INT; sleep 86400 & wait"

CMD exec /bin/bash -c "/opt/snappydata/snappydata-0.6.1-bin/bin/snappy-shell server start -dir=/opt/snappydata/data/server/ -bind-address=172.17.0.3 -client-bind-address=localhost -locators=localhost:9999, -dir=/opt/snappydata/data/server -client-bind-address=172.17.0.3 -J-Duser.timezone=UTC -J-Djava.net.preferIPv4Stack=true  -thrift-server-address=172.17.0.3 -heap-size=4096m -thrift-server-port=1531 -thrift-binary-protocol=true && trap : TERM INT; sleep 86400 & wait"

CMD exec /bin/bash -c "/opt/snappydata/snappydata-0.6.1-bin/bin/snappy-shell leader start -dir=/opt/snappydata/data/locator/ -peer-discovery-address=localhost -client-bind-address=localhost  -peer-discovery-port=9999 && trap : TERM INT; sleep 86400 & wait"
```

## Todo
```docker
docker run -it snappydatainc/snappydata /bin/bash -c "mkdir /locator/ && /opt/snappydata/bin/snappy-shell locator start -dir=/locator -peer-discovery-address=localhost -client-bind-address=localhost -peer-discovery-port=9999 && trap : TERM INT; tail -f /locator/snappylocator.log"

docker run -it snappydatainc/snappydata /bin/bash -c "mkdir /server && /opt/snappydata/bin/snappy-shell server start -dir=/opt/snappydata/data/server/ -bind-address=172.17.0.3 -client-bind-address=localhost -locators=localhost:9999, -dir=/server -client-bind-address=172.17.0.3 -J-Duser.timezone=UTC -J-Djava.net.preferIPv4Stack=true  -thrift-server-address=172.17.0.3 -heap-size=4096m -thrift-server-port=1531 -thrift-binary-protocol=true && trap : TERM INT; tail -f /locator/snappyserver.log"

docker run -it snappydatainc/snappydata /bin/bash -c "mkdir /leader && /opt/snappydata/bin/snappy-shell leader start -dir=/leader/ -peer-discovery-address=localhost -client-bind-address=localhost  -peer-discovery-port=9999 && trap : TERM INT; tail -f /locator/snappyleader.log"
```

kubectl delete pods,services,petsets -l app=snappydata-server
kubectl delete pods,services,petsets -l app=snappydata-leader 
kubectl delete pods,services,petsets -l app=snappydata-locator
kubectl delete pods,services,petsets -l app=snappydata
