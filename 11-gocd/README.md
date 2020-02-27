```
# Install k3s
# Install helm
kubectl create ns gocd
helm install gocd stable/gocd --namespace gocd --set agent.replicaCount=3 --set agent.image.repository="ifire/gocd-agent-fedora-30" --set agent.image.tag=v19.9.0-chibifire-0.1 --set agent.security.ssh.enabled=true --set server.security.ssh.enabled=true --kubeconfig /etc/rancher/k3s/k3s.yaml

# https://github.com/helm/charts/tree/master/stable/gocd#ssh-keys
For accessing repositories over SSH in GoCD server, you need to add SSH keys to the GoCD server. Generate a new keypair, fetch the host key for the [host] you want to connect to and create the secret. The secret is structured to hold the entire contents of the .ssh folder on the GoCD server.

$ ssh-keygen -t rsa -b 4096 -C "user@example.com" -f gocd-server-ssh -P ''
$ ssh-keyscan [host] > gocd_known_hosts
$ kubectl create secret generic gocd-server-ssh \
   --from-file=id_rsa=gocd-server-ssh \
   --from-file=id_rsa.pub=gocd-server-ssh.pub \
   --from-file=known_hosts=gocd_known_hosts -n gocd

# https://github.com/helm/charts/tree/master/stable/gocd#ssh-keys-1
SSH keys

For accessing repositories over SSH in GoCD agent, you need to add SSH keys to the GoCD agent. Generate a new keypair, fetch the host key for the [host] you want to connect to and create the secret. The secret is structured to hold the entire contents of the .ssh folder on the GoCD agent.

$ ssh-keygen -t rsa -b 4096 -C "user@example.com" -f gocd-agent-ssh -P ''
$ ssh-keyscan [host] > gocd_known_hosts
$ kubectl create secret generic gocd-agent-ssh \
   --from-file=id_rsa=gocd-agent-ssh \
   --from-file=id_rsa.pub=gocd-agent-ssh.pub \
   --from-file=known_hosts=gocd_known_hosts -n gocd

```
