#!/bin/bash
if [ $# -ne 1 ]; then
        echo "Please pass ZK:Port to run as the first argument."
else
	./kafka-topics.sh \
	--create \
	--zookeeper $1 \
	--replication-factor 2 \
	--partitions 4 \
	--topic gateway-west-raw-sensors;

	./kafka-topics.sh \
	--create \
	--zookeeper $1 \
	--replication-factor 2 \
	--partitions 4 \
	--topic gateway-central-raw-sensors;

	./kafka-topics.sh \
	--create \
	--zookeeper $1 \
	--replication-factor 2 \
	--partitions 4 \
	--topic gateway-east-raw-sensors;

	./kafka-topics.sh \
	--create \
	--zookeeper $1 \
	--replication-factor 2 \
	--partitions 3 \
	--topic syndicate-geo-event-avro;

	./kafka-topics.sh \
	--create \
	--zookeeper $1 \
	--replication-factor 2 \
	--partitions 3 \
	--topic syndicate-speed-event-avro;

	./kafka-topics.sh \
	--create \
	--zookeeper $1 \
	--replication-factor 2 \
	--partitions 3 \
	--topic syndicate-geo-event-json;

	./kafka-topics.sh \
	--create \
	--zookeeper $1 \
	--replication-factor 2 \
	--partitions 3 \
	--topic syndicate-speed-event-json;

	./kafka-topics.sh \
	--create \
	--zookeeper $1 \
	--replication-factor 2 \
	--partitions 3 \
	--topic alerts-speeding-drivers;
fi