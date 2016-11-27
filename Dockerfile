FROM williamyeh/ansible:alpine3-onbuild

# ==> Specify requirements filename;  default = "requirements.yml"
#ENV REQUIREMENTS  requirements.yml

# ==> Specify playbook filename;      default = "playbook.yml"
ENV PLAYBOOK      playbook-alpine.yml

# ==> Specify inventory filename;     default = "/etc/ansible/hosts"
#ENV INVENTORY     inventory.ini

EXPOSE 1527
EXPOSE 4040
EXPOSE 7070
EXPOSE 8080
EXPOSE 10334

# ==> Executing Ansible (with a simple wrapper)...
RUN ansible-playbook-wrapper
