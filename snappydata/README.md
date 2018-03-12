## Install Guide

```
# These instructions don't work.
# Ubuntu
# sudo apt install python-pip
# sudo pip install ansible-container[docker,openshift]
# End
sudo git clone https://github.com/ansible/ansible-container.git -b develop
sudo pip install .[docker,openshift]
sudo ansible-container build
sudo ansible-container push --username=ifire --push-to docker
```
