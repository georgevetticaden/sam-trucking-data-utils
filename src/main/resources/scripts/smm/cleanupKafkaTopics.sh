#!/bin/bash
if [ $# -ne 1 ]; then
        echo "Please pass ZK:Port to run as the first argument."
else
	./kafka-topics.sh --zookeeper $1 --topic gateway-west-raw-sensors --delete ;
	./kafka-topics.sh --zookeeper $1 --topic gateway-central-raw-sensors --delete ;
	./kafka-topics.sh --zookeeper $1 --topic gateway-east-raw-sensors --delete ;
	./kafka-topics.sh --zookeeper $1 --topic syndicate-geo-event-avro --delete ;
	./kafka-topics.sh --zookeeper $1 --topic syndicate-speed-event-avro --delete ;
	./kafka-topics.sh --zookeeper $1 --topic syndicate-geo-event-json --delete ;
	./kafka-topics.sh --zookeeper $1 --topic syndicate-speed-event-json --delete ;
	./kafka-topics.sh --zookeeper $1 --topic alerts-speeding-drivers --delete ;
fi