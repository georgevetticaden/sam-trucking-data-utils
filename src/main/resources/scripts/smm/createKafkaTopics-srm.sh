#!/bin/bash
if [ $# -ne 1 ]; then
        echo "Please pass ZK:Port to run as the first argument."
else
	/usr/hdf/current/kafka-broker/bin/kafka-topics.sh \
	--create \
	--zookeeper $1 \
	--replication-factor 2 \
	--partitions 3 \
	--topic gateway-west-raw-sensors;

	/usr/hdf/current/kafka-broker/bin/kafka-topics.sh \
	--create \
	--zookeeper $1 \
	--replication-factor 2 \
	--partitions 3 \
	--topic gateway-central-raw-sensors;

	/usr/hdf/current/kafka-broker/bin/kafka-topics.sh \
	--create \
	--zookeeper $1 \
	--replication-factor 2 \
	--partitions 3 \
	--topic gateway-east-raw-sensors;
	
	/usr/hdf/current/kafka-broker/bin/kafka-topics.sh \
	--create \
	--zookeeper $1 \
	--replication-factor 2 \
	--partitions 3 \
	--topic gateway-europe-raw-sensors;	

	/usr/hdf/current/kafka-broker/bin/kafka-topics.sh \
	--create \
	--zookeeper $1 \
	--replication-factor 2 \
	--partitions 3 \
	--topic syndicate-geo-event-avro;

	/usr/hdf/current/kafka-broker/bin/kafka-topics.sh \
	--create \
	--zookeeper $1 \
	--replication-factor 2 \
	--partitions 3 \
	--topic syndicate-speed-event-avro;

	/usr/hdf/current/kafka-broker/bin/kafka-topics.sh \
	--create \
	--zookeeper $1 \
	--replication-factor 2 \
	--partitions 3 \
	--topic syndicate-geo-event-json;

	/usr/hdf/current/kafka-broker/bin/kafka-topics.sh \
	--create \
	--zookeeper $1 \
	--replication-factor 2 \
	--partitions 3 \
	--topic syndicate-speed-event-json;

	
	/usr/hdf/current/kafka-broker/bin/kafka-topics.sh \
	--create \
	--zookeeper $1 \
	--replication-factor 2 \
	--partitions 3 \
	--topic syndicate-oil;	
	
	/usr/hdf/current/kafka-broker/bin/kafka-topics.sh \
	--create \
	--zookeeper $1 \
	--replication-factor 2 \
	--partitions 3 \
	--topic syndicate-battery;
	
	/usr/hdf/current/kafka-broker/bin/kafka-topics.sh \
	--create \
	--zookeeper $1 \
	--replication-factor 2 \
	--partitions 3 \
	--topic syndicate-transmission;
	
	/usr/hdf/current/kafka-broker/bin/kafka-topics.sh \
	--create \
	--zookeeper $1 \
	--replication-factor 2 \
	--partitions 3 \
	--topic syndicate-all-geo-critical-events;
	
    
     /usr/hdf/current/kafka-broker/bin/kafka-topics.sh \
    --create \
    --zookeeper $1 \
    --replication-factor 2 \
    --partitions 3 \
    --topic gateway-geo-raw-sensor;    
    
     /usr/hdf/current/kafka-broker/bin/kafka-topics.sh \
    --create \
    --zookeeper $1 \
    --replication-factor 2 \
    --partitions 3 \
    --topic gateway-speed-raw-sensor;      
       	
				
fi