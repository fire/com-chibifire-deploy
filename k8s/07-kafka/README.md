## How to create a kafka topic?

```
# Enter a kafka machine
cd /opt/kafka
export TOPIC_NAME=topicName01
bin/kafka-topics.sh --zookeeper zk:2181 --create --topic $TOPIC_NAME --partitions 2 --replication-factor 2
```

## How to delete a kafka topic?

```
# Enter a kafka machine
cd /opt/kafka
export TOPIC_NAME=topicName01
/opt/kafka$ bin/kafka-topics.sh --delete --zookeeper zk:2181 --delete --topic $TOPIC_NAME
```
