```
helm install --name keycloak stable/keycloak
kubectl create -f keycloak-ingress.yaml
# Edit kube-lego-nginx
- host: spark.apps.example.com
  http:
    paths:
    - backend:
        serviceName: kube-lego-nginx
        servicePort: 8080
    path: /.well-known/acme-challenge
```