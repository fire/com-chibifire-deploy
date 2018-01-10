kubectl scale statefulsets snappydata-server --replicas=5
kubectl scale statefulsets snappydata-leader --replicas=3
kubectl scale statefulsets snappydata-locator --replicas=2

