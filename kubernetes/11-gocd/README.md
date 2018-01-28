Create a private key.

```
mkdir /home/go/.ssh/
chown -R go:go /home/go/.ssh
su go
ssh-keygen -t rsa -b 4096 -C "build@build.apps.chibifire.com"
# /home/go/.ssh/id_rsa
eval $(ssh-agent -s)
ssh-add /home/go/.ssh/id_rsa
ssh-add -L
# Copy to repo settings
ssh git@git.chibifire.com
# Accept

mkdir -p /home/go/.ssh/
chown -R go:go /home/go/.ssh
su go
ssh-keygen -t rsa -b 4096 -C "build-agent-0@build.apps.chibifire.com"
eval $(ssh-agent -s)
ssh-add /home/go/.ssh/id_rsa
ssh-add -L
# Copy to repo settings
ssh git@git.chibifire.com
# Accept

# For any number of agents.
```