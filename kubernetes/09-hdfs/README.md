Easiest HDFS cluster in the world with kubernetes. 

[Inspiration from kimoonkim/kubernetes-HDFS](https://github.com/kimoonkim/kubernetes-HDFS/tree/master/charts/hdfs-namenode-k8s)

```
kubectl create -f namenode.yaml
kubectl create -f datanode.yaml
```

Setup a port-forward to so you can see it is alive:
```
kubectl port-forward hdfs-namenode-0 50070:50070
```

Then in your browser hit to check out the datanodes:
```
http://localhost:50070/dfshealth.html#tab-datanode
```
_You should see a datanode list with one node in it_

Back in your console, scale it up!!
```
kubectl scale statefulset hdfs-datanode --replicas=3
```

Refresh your browser. Bada boom!
```
http://localhost:50070/dfshealth.html#tab-datanode
```
_You should see a datanode list with three nodes in it_

Now start hadoop'n

```
kubectl exec -ti hdfs-namenode-0 /bin/bash
root@hdfs-namenode-0:/# hadoop fs -mkdir /tmp
root@hdfs-namenode-0:/# hadoop fs -put /bin/systemd /tmp/ # just upload the systemd binary into hdfs to see if it working (could be any file)
root@hdfs-namenode-0:/# hadoop fs -ls /tmp
Found 1 items
-rw-r--r--   3 root supergroup    1313160 2017-05-03 21:15 /tmp/systemd
```