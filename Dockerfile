FROM williamyeh/ansible:alpine3-onbuild

# ==> Specify requirements filename;  default = "requirements.yml"
#ENV REQUIREMENTS  requirements.yml

# ==> Specify playbook filename;      default = "playbook.yml"
ENV PLAYBOOK      playbook-alpine.yml

# ==> Specify inventory filename;     default = "/etc/ansible/hosts"
#ENV INVENTORY     inventory.ini

# ==> Executing Ansible (with a simple wrapper)...
RUN ansible-playbook-wrapper
