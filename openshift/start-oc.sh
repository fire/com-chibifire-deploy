#!/bin/bash
#Copyright 2018 K. S. Ernest (iFire) Lee
#
#Licensed under the Apache License, Version 2.0 (the "License");
#you may not use this file except in compliance with the License.
#You may obtain a copy of the License at
#
#http://www.apache.org/licenses/LICENSE-2.0
#
#Unless required by applicable law or agreed to in writing, software
#distributed under the License is distributed on an "AS IS" BASIS,
#WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#See the License for the specific language governing permissions and
#limitations under the License.
#
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
