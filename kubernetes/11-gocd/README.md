
Create a private key.

Login: `kubectl exec -it gocd-agent-centos-7-0 bash`

```
# For any number of agents.
mkdir -p /home/go/.ssh/
chown -R go:go /home/go/.ssh
su go
ssh-keygen -t rsa -b 4096 -C "build-agent-0@build.apps.chibifire.com"
eval $(ssh-agent -s)
ssh-add /home/go/.ssh/id_rsa
ssh-add -L
# Copy to repo settings by creating the user
# Add the user to the service group
# Add ssh key to the user
ssh git@git.chibifire.com
# Accept
# Hosts keep changing in Kubernetes
vi /home/go/.ssh/config
host *.chibifire.com
    StrictHostKeyChecking no
```

3 files 
# Base64 encoded 
# Use echo -n 'secret_text' | base64 -w 0
# cat id_rsa | base64 -w 0
* /home/go/.ssh/id_rsa
* /home/go/.ssh/id_rsa.pub
* /home/go/.ssh/config

