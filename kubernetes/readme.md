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

Create a kafka topic.

```
kubectl.exe exec -it --namespace kafka kafka-0 bash
./bin/kafka-topics.sh --zookeeper zk.zk:2181 --list
./bin/kafka-topics.sh --zookeeper zk.zk:2181 --create --topic topicName --partitions=3 --replication=1
```

Start a snappydata client.

```
kubectl run snappydata-client -it --image=snappydatainc/snappydata  --rm --restart=Never /bin/bash
/opt/snappydata/bin/snappy-shell
connect client 'snappydata-locator-0:1527';
select id, kind, status, host, port from sys.members;
```

Proxy spark ui.

```
kubectl port-forward snappydata-leader-0 4040
```

Run top / htop.

```
export TERM=xterm
yum install epel-release
yum install htop
htop
```

Proxy streamsets ui.

```
kubectl port-forward --namespace streamsets streamsets-0 18630
```

Proxy pulse snappydata ui admin.

```
kubectl port-forward --namespace snappydata snappydata-locator-0 7070
```

Procedure to restart zookeeper. First reduce the number of replicas to 1. Restart the pod and then set the replicas back to 3.
