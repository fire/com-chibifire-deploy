# How to install perforce on kubernetes


## Perforce is licensed under it own license.

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