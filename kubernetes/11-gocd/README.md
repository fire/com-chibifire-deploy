# README.md

# Setup 
Create a private key.

Login: `kubectl exec -it gocd-agent-centos-7-0 bash`

```
# Add kubernetes secret
ssh-keygen -t rsa -b 4096 -C "build-agent-0@build.apps.chibifire.com"
# Get fingerprint
eval $(ssh-agent -s)
ssh-add ~/.ssh/id_rsa
ssh-add -L
# Copy to .ssh/config
vi /home/go/.ssh/config
host *.chibifire.com
    StrictHostKeyChecking no

# 3 Files
# Base64 encoded 
# cat id_rsa | base64 -w 0
# cat id_rsa.pub | base64 -w 0
# cat config | base64 -w 0
# Copy these base64 text to the secrets template.

# To convert base64 text back
# echo -n 'secret_text' | base64 -w 0
```

Add github authorization.

Create a pipeline and look at the xml to generate the encrypted value.
