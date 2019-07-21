```
sudo ln -s /home/local-path-provisioner/ /opt/local-path-provisioner
# Copy /etc/rancher/k3s/k3s.yaml to ~/.kube/config
kubectl create -f https://raw.githubusercontent.com/rancher/local-path-provisioner/master/deploy/local-path-storage.yaml --kubeconfig /etc/rancher/k3s/k3s.yaml
kubectl apply -f https://raw.githubusercontent.com/rancher/local-path-provisioner/master/deploy/local-path-storage.yaml  --kubeconfig /etc/rancher/k3s/k3s.yaml
kubectl patch storageclass local-path -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}' --kubeconfig /etc/rancher/k3s/k3s.yaml
kubectl --kubeconfig /etc/rancher/k3s/k3s.yaml create -f .
kubectl --kubeconfig /etc/rancher/k3s/k3s.yaml apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v1.10.1/src/deploy/recommended/kubernetes-dashboard.yaml
kubectl --kubeconfig /etc/rancher/k3s/k3s.yaml proxy
```
