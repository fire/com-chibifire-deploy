# SnappyData for openshift
## How to create a kafka topic?

```
# Enter a kafka machine
cd /opt/kafka
export TOPIC_NAME=topicName01
bin/kafka-topics.sh --zookeeper zk:2181 --create --topic $TOPIC_NAME --partitions 2 --replication-factor 2
```

## How to delete a kafka topic?

```
# Enter a kafka machine
cd /opt/kafka
export TOPIC_NAME=topicName01
/opt/kafka$ bin/kafka-topics.sh --delete --zookeeper zk:2181 --delete --topic $TOPIC_NAME
```

## How to start a openshift cluster?

```
#On centos atomic vm
#Enable insecure registry
#Disable firewalls
# Add
sudo -s
echo "INSECURE_REGISTRY='--insecure-registry 172.30.0.0/16'" >> /etc/sysconfig/docker
exit
sudo iptables -F # Find a better way of disabling firewalls
sudo systemctl enable docker
sudo service docker restart
wget https://github.com/openshift/origin/releases/download/v1.5.0-alpha.2/openshift-origin-server-v1.5.0-alpha.2-e4b43ee-linux-64bit.tar.gz
tar xvf openshift-origin-server-v1.5.0-alpha.2-e4b43ee-linux-64bit.tar.gz
# Remember to change the public hostname
sudo ./oc cluster up \
--public-hostname="$(ip -o -4 addr list eth0 | awk '{print $4}' | cut -d/ -f1)" \
--host-volumes-dir='/home/atomic/openshift-origin-server-v1.5.0-alpha.2+e4b43ee-linux-64bit/pv' \
--host-data-dir='/home/atomic/openshift-origin-server-v1.5.0-alpha.2+e4b43ee-linux-64bit/data' \
--logging=true # Ignore metrics --metrics=true
# Notes
See https://github.com/openshift/origin/issues/11949
https://docs.openshift.org/latest/getting_started/administrators.html
```

## How to shutdown the openshift cluster?

```
oc cluster down
```

## How to shutdown the snappydata cluster on openshift?

```
oc exec -it snappydata-locator-0 bash
/opt/snappydata/bin/snappy-shell
connect client '172.17.0.7:1527';
shut-down-all -locators=snappydata-locator-0.snappydata-locator.snappydata:10334;
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

## Installing ycsb
```
kubectl run snappydata-client -it --image=openjdk/8u111-jdk-alpine  --rm --restart=Never /bin/bash
docker run -it <containername> /bin/bash
./bin/ycsb load snappystore -P workloads/workloada -s -threads 4 -p recordcount=50000
./bin/ycsb run snappystore -P workloads/workloada -s -threads 4 -p operationcount=5000000 -p requestdistribution=zipfian
```

## Install a recent git on Centos 6

```
yum install epel-release
rpm -i https://centos6.iuscommunity.org/ius-release.rpm
yum remove git
yum install git2u
```

## Install ycsb client

```
```

## Win10 - Start Kubernetes cluster on Hyperv

Install Docker for Windows.

Install minikube.

Start minikube.

In hyperv create a virtual switch to your network.

```
REM MUST BE ON THE C DRIVE
minikube.exe start --vm-driver="hyperv" --cpus="8" --memory="32768" --hyperv-virtual-switch=Lan
minikube addons enable heapster
minikube addons enable dashboard
# wait
minikube addons open dashboard
kubectl create -f ./1-setup
kubectl create -f ./2-services
```

## Win10 - Start Kubernetes cluster on Virtualbox

Install Docker for Windows.

Install minikube.

Start minikube.

In hyperv create a virtual switch to your network.

```
minikube.exe start --cpus="8" --memory="32768" # Adjust as you wish
minikube addons enable heapster
minikube addons enable dashboard
# wait
minikube addons open dashboard
kubectl create -f ./1-setup
kubectl create -f ./2-services
```

## Ubuntu - Start Kubernetes cluster on Libvirt

Install Docker.io

```
sudo apt install docker
```

Install minikub.  

```
curl -Lo minikube https://storage.googleapis.com/minikube/releases/v0.14.0/minikube-linux-amd64 && chmod +x minikube && sudo mv minikube /usr/local/bin/
```

"Feel free to leave off the sudo mv minikube /usr/local/bin if you would like to add minikube to your path manually." - https://github.com/kubernetes/minikube/releases

Install kvm driver

```
sudo curl -L https://github.com/dhiltgen/docker-machine-kvm/releases/download/v0.7.0/docker-machine-driver-kvm -o /usr/local/bin/docker-machine-driver-kvm
sudo chmod +x /usr/local/bin/docker-machine-driver-kvm

# Install libvirt and qemu-kvm on your system, e.g.
# Debian/Ubuntu
sudo apt install libvirt-bin qemu-kvm

# Add yourself to the libvirtd group (use libvirt group for rpm based distros) so you don't need to sudo
sudo usermod -a -G libvirtd $(whoami)

# Update your current session for the group change to take effect
newgrp libvirtd
```

Install Kubectl

```
curl -Lo kubectl https://storage.googleapis.com/kubernetes-release/release/v1.5.1/bin/linux/amd64/kubectl && chmod +x kubectl && sudo mv kubectl /usr/local/bin/
```

Start minikube.
```
minikube start --vm-driver=kvm --cpus="8" --memory="32768" # Adjust as you wish
minikube addons enable heapster
minikube addons enable dashboard
# wait
minikube addons open dashboard
kubectl create -f ./1-setup
kubectl create -f ./2-services
```