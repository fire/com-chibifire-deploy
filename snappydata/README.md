# What is SnappyData?

https://github.com/SnappyDataInc/snappydata

SnappyData is a **distributed in-memory data store for real-time operational analytics, delivering stream analytics, OLTP (online transaction processing) and OLAP (online analytical processing) in a single integrated cluster**. We realize this platform through a seamless integration of Apache Spark (as a big data computational engine) with GemFire XD (as an in-memory transactional store with scale-out SQL semantics).

See vagrant instructions.

See kubernetes instructions.

## Install Guide

```
sudo git clone https://github.com/ansible/ansible-container.git -b develop
sudo pip install .[docker,openshift]
sudo ansible-container build
sudo ansible-container push --username=ifire --push-to docker
```
