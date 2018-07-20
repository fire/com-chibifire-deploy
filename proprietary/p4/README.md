# How to install perforce on kubernetes

## Perforce is licensed under its own license.

## Install Guide

```
kubectl create -f perforce.yml
```

## Development guide

```
sudo git clone https://github.com/tobill/ansible-container.git -b develop
sudo pip install -e .[docker,openshift]
sudo ansible-container build
sudo ansible-container push --username=ifire --push-to docker
```

```
# Open port 1666.
su perforce
! [ ! -f /perforce/servers/p4-master/ssl/certificate.txt ] || P4SSLDIR=/perforce/servers/p4-master/ssl/ /usr/sbin/p4d -Gc || true
P4JOURNAL=/perforce/servers/p4-master/p4journal P4LOG=/perforce/var/log/perforce/p4err P4ROOT=/perforce/servers/p4-master/p4root P4PORT=ssl:1666 P4SSLDIR=/perforce/servers/p4-master/ssl PATH=/bin:/usr/bin:/usr/local/bin P4DEBUG=0 /usr/sbin/p4d -C1
```
