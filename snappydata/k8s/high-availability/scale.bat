kubectl scale statefulsets snappydata-server --replicas=3
kubectl scale statefulsets snappydata-leader --replicas=1
kubectl scale statefulsets snappydata-locator --replicas=2

