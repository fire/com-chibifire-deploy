kubectl.exe exec -it kafka-0 bash
./bin/kafka-topics.sh --zookeeper zk:2181 --list
./bin/kafka-topics.sh --zookeeper zk:2181 --create --topic jsonTest --partitions=3 --replication=1
