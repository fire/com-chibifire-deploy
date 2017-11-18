FROM williamyeh/ansible:centos7

# ==> Specify requirements filename;  default = "requirements.yml"
#ENV REQUIREMENTS  requirements.yml

# ==> Specify playbook filename;      default = "playbook.yml"
ENV PLAYBOOK      playbook-centos.yml

# ==> Specify inventory filename;     default = "/etc/ansible/hosts"
#ENV INVENTORY     inventory.ini

EXPOSE 1527 4040 7070 8080 10334

# ==> Copying Ansible playbook...
WORKDIR /tmp
COPY  .  /tmp

# ==> Creating inventory file...
RUN echo localhost > inventory

# ==> Executing Ansible...
RUN ansible-playbook -i inventory playbook-centos.yml \
      --connection=local --sudo

CMD export USER_ID=$(id -u) && export GROUP_ID=$(id -g) && envsubst < /opt/zeppelin/passwd > /tmp/passwd && export LD_PRELOAD=/usr/lib64/libnss_wrapper.so && export NSS_WRAPPER_PASSWD=/tmp/passwd && export NSS_WRAPPER_GROUP=/etc/group && /opt/zeppelin/bin/zeppelin.sh
USER 1234321