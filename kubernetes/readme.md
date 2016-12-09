kubectl.exe exec -it kafka-0 bash
./bin/kafka-topics.sh --zookeeper zk:2181 --list
./bin/kafka-topics.sh --zookeeper zk:2181 --create --topic jsonTest --partitions=3 --replication=1

minikube.exe start --vm-driver="hyperv" --cpus="8" --memory="32768"
minikube addons open dashboard

