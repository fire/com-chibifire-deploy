cd ~
pip install virtualenv
virtualenv ansible-container
source ansible-container/bin/activate
pip install ansible-container[docker,openshift]
cd -
