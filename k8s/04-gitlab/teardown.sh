#!/bin/bash

if ! which -s kubectl; then
  echo "kubectl command not installed"
  exit 1
fi

# delete the replication controllers
for rc in *-ingress.yml
do
  echo -n "Deleting $rc... "
  kubectl -f $rc delete
done


# delete the services
for svc in *-svc.yml
do
  echo -n "Deleting $svc... "
  kubectl -f $svc delete
done

# delete the replication controllers
for rc in *-statefulset.yml
do
  echo -n "Deleting $rc... "
  kubectl -f $rc delete
done
