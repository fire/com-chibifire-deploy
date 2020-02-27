```
# Install k3s
# Install helm
helm install gocd stable/gocd --namespace gocd --set agent.image.repository=ifire/gocd-agent-fedora-30 --set agent.security.ssh.enabled=true --set server.security.ssh.enabled=true --kubeconfig /etc/rancher/k3s/k3s.yaml
# helm status gocd-app --kubeconfig /etc/rancher/k3s/k3s.yaml
```
