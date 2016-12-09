kubectl.exe exec -it kafka-0 bash
./bin/kafka-topics.sh --zookeeper zk:2181 --list
./bin/kafka-topics.sh --zookeeper zk:2181 --create --topic jsonTest --partitions=3 --replication=1

curl -sL https://github.com/SnappyDataInc/snappydata/releases/download/v0.6.1/snappydata-client-1.5.2.jar > /data/snappydata-client-1.5.2.jar
