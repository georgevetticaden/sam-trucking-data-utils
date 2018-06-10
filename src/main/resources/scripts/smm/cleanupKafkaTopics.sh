#!/bin/bash
if [ $# -ne 1 ]; then
        echo "Please pass ZK:Port to run as the first argument."
else
	/usr/hdp/current/kafka-broker/bin/kafka-topics.sh --zookeeper $1 --topic gateway-west-raw-sensors --delete ;
	/usr/hdp/current/kafka-broker/bin/kafka-topics.sh --zookeeper $1 --topic gateway-central-raw-sensors --delete ;
	/usr/hdp/current/kafka-broker/bin/kafka-topics.sh --zookeeper $1 --topic gateway-east-raw-sensors --delete ;
	/usr/hdp/current/kafka-broker/bin/kafka-topics.sh --zookeeper $1 --topic gateway-europe-raw-sensors --delete ;
	/usr/hdp/current/kafka-broker/bin/kafka-topics.sh --zookeeper $1 --topic syndicate-geo-event-avro --delete ;
	/usr/hdp/current/kafka-broker/bin/kafka-topics.sh --zookeeper $1 --topic syndicate-speed-event-avro --delete ;
	/usr/hdp/current/kafka-broker/bin/kafka-topics.sh --zookeeper $1 --topic syndicate-geo-event-json --delete ;
	/usr/hdp/current/kafka-broker/bin/kafka-topics.sh --zookeeper $1 --topic syndicate-speed-event-json --delete ;
	/usr/hdp/current/kafka-broker/bin/kafka-topics.sh --zookeeper $1 --topic alerts-speeding-drivers --delete ;
fi