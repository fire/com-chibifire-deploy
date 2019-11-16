#!/bin/bash

if ! which -s kubectl; then
  echo "kubectl command not installed"
  exit 1
fi

# create the services
for svc in *-svc.yml
do
  echo -n "Creating $svc... "
  kubectl -f $svc create
done

# create the replication controllers
for rc in *-statefulset.yml
do
  echo -n "Creating $rc... "
  kubectl -f $rc create
done

# create the ingress controllers
for rc in *-ingress.yml
do
  echo -n "Creating $rc... "
  kubectl -f $rc create
done

# list pod,rc,svc
echo "Pod:"
kubectl get pod

echo "RC:"
kubectl get rc

echo "Service:"
kubectl get svc
