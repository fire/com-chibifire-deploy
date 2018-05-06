#!/bin/bash
# Install docker
# sudo yum install docker
# Start docker
# Add registry
# sudo nano /etc/docker/daemon.json
#{
#    "insecure-registries" : [ "172.30.0.0/16" ]
#}
# sudo systemctl enable docker
# sudo systemctl restart docker
# Install openshift binary oc
# sudo yum install origin
ORIGIN_DIR=`dirname "$(readlink -f "$0")"`
sudo oc cluster up --use-existing-config=true --version=v3.9.0  --host-config-dir $ORIGIN_DIR/openshift.local.config --host-volumes-dir $ORIGIN_DIR/openshift.local.volumes --host-pv-dir $ORIGIN_DIR/openshift.local.pv --host-data-dir $ORIGIN_DIR/hostdata --logging=true --public-hostname `hostname`
