# Win10 - Start Kubernetes cluster on Hyperv

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

