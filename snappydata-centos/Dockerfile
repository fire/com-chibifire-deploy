FROM williamyeh/ansible:centos7-onbuild

# ==> Specify requirements filename;  default = "requirements.yml"
#ENV REQUIREMENTS  requirements.yml

# ==> Specify playbook filename;      default = "playbook.yml"
ENV PLAYBOOK      playbook-centos.yml

# ==> Specify inventory filename;     default = "/etc/ansible/hosts"
#ENV INVENTORY     inventory.ini

EXPOSE 1527 4040 7070 8080 10334

# ==> Executing Ansible (with a simple wrapper)...
RUN ansible-playbook-wrapper

CMD export USER_ID=$(id -u) && export GROUP_ID=$(id -g) && envsubst < /opt/snappydata/passwd > /tmp/passwd && export LD_PRELOAD=/usr/lib64/libnss_wrapper.so && export NSS_WRAPPER_PASSWD=/tmp/passwd && export NSS_WRAPPER_GROUP=/etc/group && /usr/local/bin/start all
USER 1234321