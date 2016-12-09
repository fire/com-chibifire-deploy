# Setup Guide

## Start Kubernetes cluster

Install Docker for Windows.

Install minikube.

Start minikube.

In hyperv create a virtual switch to your network.

```
minikube.exe start --vm-driver="hyperv" --cpus="8" --memory="32768" --hyperv-virtual-switch=Lan
minikube addons enable heapster
minikube addons enable dashboard
# wait
minikube addons open dashboard
kubectl create -f ./1-setup
kubectl create -f ./2-services
```

## Misc commands.

```
kubectl.exe exec -it kafka-0 bash
./bin/kafka-topics.sh --zookeeper zk:2181 --list
./bin/kafka-topics.sh --zookeeper zk:2181 --create --topic jsonTest --partitions=3 --replication=1
```
