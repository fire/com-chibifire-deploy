```
./k3s kubectl create -f https://raw.githubusercontent.com/rancher/local-path-provisioner/master/deploy/local-path-storage.yaml --kubeconfig /etc/rancher/k3s/k3s.yaml
sudo ln -s /home/local-path-provisioner/ /opt/local-path-provisioner
./k3s kubectl apply -f https://raw.githubusercontent.com/rancher/local-path-provisioner/master/deploy/local-path-storage.yaml  --kubeconfig /etc/rancher/k3s/k3s.yaml
./k3s kubectl patch storageclass local-path -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}' --kubeconfig /etc/rancher/k3s/k3s.yaml
./k3s kubectl --kubeconfig /etc/rancher/k3s/k3s.yaml create -f .
./k3s kubectl --kubeconfig /etc/rancher/k3s/k3s.yaml apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v1.10.1/src/deploy/recommended/kubernetes-dashboard.yaml
./k3s kubectl --kubeconfig /etc/rancher/k3s/k3s.yaml proxy
ssh centos@192.168.0.30 -L 8001:localhost:8001
```
