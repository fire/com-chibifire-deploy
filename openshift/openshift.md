# How to setup an Openshift instance?

## Storage

## How to shutdown the openshift cluster?

```
oc cluster down
```

## How to start the snappydata cluster on openshift?

```
# Login
oc new-project snappydata
oc create -f kubernetes\02-services\1-snappydata\
```

## How to shutdown the snappydata cluster on openshift?

```
oc exec -it snappydata-locator-0 bash
/opt/snappydata/bin/snappy-shell
connect client '172.17.0.7:1527';
shut-down-all -locators=snappydata-locator-0.snappydata-locator.snappydata:10334;
```
