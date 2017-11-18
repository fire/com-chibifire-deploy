#!/bin/bash


env | grep ALLUXIO_ | sed 's/ALLUXIO_/export ALLUXIO_/g' > /alluxio-environment.sh

if [ ! -s /alluxio/conf/workers ] ; then 
    cp /alluxio/defaultConf/workers /alluxio/conf/workers
fi

if [ ! -s /alluxio/conf/masters ] ; then 
    cp /alluxio/defaultConf/masters /alluxio/conf/masters
fi

if [ ! -s /alluxio/conf/alluxio-siteproperties ] ; then 
    cp /alluxio/defaultConf/alluxio-siteproperties /alluxio/conf/alluxio-siteproperties
fi

if [ ! -s /alluxio/conf/log4j.properties ] ; then 
    cp /alluxio/defaultConf/log4j.properties /alluxio/conf/log4j.properties
fi

ADD workers
ADD masters /alluxio/defaultConf/
ADD log4j.properties /alluxio/defaultConf/
ADD alluxio-site.properties /alluxio/defaultConf/

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

