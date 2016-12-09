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

CMD ["sudo", "-u", "snappydata", "/usr/local/bin/start", "all"]