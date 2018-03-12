## Install Guide

```
# These instructions don't work.
# Ubuntu
# sudo apt install python-pip
# sudo pip install ansible-container[docker,openshift]
# End
sudo git clone https://github.com/ansible/ansible-container.git
sudo pip install .
ansible-container build
ansible-container push --username=ifire --push-to docker
```
