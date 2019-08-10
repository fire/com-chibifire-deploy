# SnappyData for openshift

## How to start Snappydata?

```
oc project project-name
oc create -f .
```

## How to get certificate for Dbeaver?

```
oc project project-name
oc cp snappydata-server-1:/var/run/secrets/java.io/keystores/keystore.jks keystore.jks
```

This is the jdbc url:

```
jdbc:snappydata://example.com:1527/;framed-transport=true;binary-protocol=true;load-balance=true;ssl=true;ssl-properties=truststore=keystore.jks,truststore-password=password,protocol=TLS,enabled-protocols=TLSv1:TLSv1.1:TLSv1.2,cipher-suites=TLS_RSA_WITH_AES_128_CBC_SHA:TLS_RSA_WITH_AES_256_CBC_SHA:TLS_RSA_WITH_AES_128_CBC_SHA256:TLS_RSA_WITH_AES_256_CBC_SHA256
```


## How to stop and start SnappyData?

```bash
# Stop everything
oc scale statefulsets snappydata-leader --replicas=0
oc scale statefulsets snappydata-server --replicas=0
oc scale statefulsets snappydata-locator --replicas=0

# Start locators. Needed to find other servers.
oc scale statefulsets snappydata-locator --replicas=2
oc scale statefulsets snappydata-server --replicas=3
oc scale statefulsets snappydata-leader --replicas=2
```

## Misc commands.

Start a snappydata client.

```
kubectl run snappydata-client -it --image=snappydatainc/snappydata  --rm --restart=Never /bin/bash
/opt/snappydata/bin/snappy-shell
connect client 'snappydata-locator-0:1527';
select id, kind, status, host, port from sys.members;
```

Proxy pulse snappydata ui admin.

```
kubectl port-forward --namespace snappydata snappydata-locator-0 7070
```

## Installing ycsb

```
kubectl run snappydata-client -it --image=openjdk/8u111-jdk-alpine  --rm --restart=Never /bin/bash
docker run -it <containername> /bin/bash
./bin/ycsb load snappystore -P workloads/workloada -s -threads 4 -p recordcount=50000
./bin/ycsb run snappystore -P workloads/workloada -s -threads 4 -p operationcount=5000000 -p requestdistribution=zipfian
```

Proxy spark ui.

```
kubectl port-forward snappydata-leader-0 4040
```

Run top / htop.

```
export TERM=xterm
yum install epel-release
yum install htop
htop
```
