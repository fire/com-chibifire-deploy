#!/bin/bash


env | grep ALLUXIO_ | sed 's/ALLUXIO_/export ALLUXIO_/g' > /alluxio-environment.sh



if [ "$1" == "master" ]; then
    echo "Starting alluxio master"
    /alluxio/bin/alluxio format
    /usr/bin/supervisord -c /supervisord-master.conf
elif [ "$1" == "slave" ]; then
    echo "Starting alluxio slave"
    /usr/bin/supervisord -c /supervisord-slave.conf
elif [ "$1" == "local" ]; then
    echo "Starting both master and slave"
    /alluxio/bin/alluxio format
    /usr/bin/supervisord -c /supervisord-local.conf
else
    echo "Starting both."
    /alluxio/bin/alluxio format
    /usr/bin/supervisord -c /supervisord-local.conf
fi

