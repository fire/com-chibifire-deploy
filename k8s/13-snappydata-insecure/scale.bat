kubectl scale statefulsets snappydata-server --replicas=3
kubectl scale statefulsets snappydata-leader --replicas=2
kubectl scale statefulsets snappydata-locator --replicas=2

