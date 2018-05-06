kubectl scale statefulsets snappydata-server --replicas=0
kubectl scale statefulsets snappydata-leader --replicas=0
kubectl scale statefulsets snappydata-locator --replicas=0

