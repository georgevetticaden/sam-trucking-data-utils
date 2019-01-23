#!/bin/bash
if [ $# -ne 1 ]; then
        echo "Please pass ZK:Port to run as the first argument."
else
	/usr/hdp/current/kafka-broker/bin/kafka-topics.sh \
	--create \
	--zookeeper $1 \
	--replication-factor 2 \
	--partitions 3 \
	--topic gateway-west-raw-sensors;

	/usr/hdp/current/kafka-broker/bin/kafka-topics.sh \
	--create \
	--zookeeper $1 \
	--replication-factor 2 \
	--partitions 3 \
	--topic gateway-central-raw-sensors;

	/usr/hdp/current/kafka-broker/bin/kafka-topics.sh \
	--create \
	--zookeeper $1 \
	--replication-factor 2 \
	--partitions 3 \
	--topic gateway-east-raw-sensors;
	
	/usr/hdp/current/kafka-broker/bin/kafka-topics.sh \
	--create \
	--zookeeper $1 \
	--replication-factor 2 \
	--partitions 3 \
	--topic gateway-europe-raw-sensors;	

	/usr/hdp/current/kafka-broker/bin/kafka-topics.sh \
	--create \
	--zookeeper $1 \
	--replication-factor 2 \
	--partitions 3 \
	--topic syndicate-geo-event-avro;

	/usr/hdp/current/kafka-broker/bin/kafka-topics.sh \
	--create \
	--zookeeper $1 \
	--replication-factor 2 \
	--partitions 3 \
	--topic syndicate-speed-event-avro;

	/usr/hdp/current/kafka-broker/bin/kafka-topics.sh \
	--create \
	--zookeeper $1 \
	--replication-factor 2 \
	--partitions 3 \
	--topic syndicate-geo-event-json;

	/usr/hdp/current/kafka-broker/bin/kafka-topics.sh \
	--create \
	--zookeeper $1 \
	--replication-factor 2 \
	--partitions 3 \
	--topic syndicate-speed-event-json;

	/usr/hdp/current/kafka-broker/bin/kafka-topics.sh \
	--create \
	--zookeeper $1 \
	--replication-factor 2 \
	--partitions 3 \
	--topic alerts-speeding-drivers;
	
	/usr/hdp/current/kafka-broker/bin/kafka-topics.sh \
	--create \
	--zookeeper $1 \
	--replication-factor 2 \
	--partitions 3 \
	--topic syndicate-oil;	
	
	/usr/hdp/current/kafka-broker/bin/kafka-topics.sh \
	--create \
	--zookeeper $1 \
	--replication-factor 2 \
	--partitions 3 \
	--topic syndicate-battery;
	
	/usr/hdp/current/kafka-broker/bin/kafka-topics.sh \
	--create \
	--zookeeper $1 \
	--replication-factor 2 \
	--partitions 3 \
	--topic syndicate-transmission;
	
	/usr/hdp/current/kafka-broker/bin/kafka-topics.sh \
	--create \
	--zookeeper $1 \
	--replication-factor 2 \
	--partitions 3 \
	--topic syndicate-all-geo-critical-events;
	
	/usr/hdp/current/kafka-broker/bin/kafka-topics.sh \
	--create \
	--zookeeper $1 \
	--replication-factor 2 \
	--partitions 3 \
	--topic fleet-supply-chain;	
	
	/usr/hdp/current/kafka-broker/bin/kafka-topics.sh \
	--create \
	--zookeeper $1 \
	--replication-factor 2 \
	--partitions 3 \
	--topic route-planning ;	
	
	/usr/hdp/current/kafka-broker/bin/kafka-topics.sh \
	--create \
	--zookeeper $1 \
	--replication-factor 2 \
	--partitions 3 \
	--topic load-optimization ;		
	
	/usr/hdp/current/kafka-broker/bin/kafka-topics.sh \
	--create \
	--zookeeper $1 \
	--replication-factor 2 \
	--partitions 3 \
	--topic fuel-logistics ;
	
	/usr/hdp/current/kafka-broker/bin/kafka-topics.sh \
	--create \
	--zookeeper $1 \
	--replication-factor 2 \
	--partitions 3 \
	--topic supply-chain ;	
	
	/usr/hdp/current/kafka-broker/bin/kafka-topics.sh \
	--create \
	--zookeeper $1 \
	--replication-factor 2 \
	--partitions 3 \
	--topic predictive-alerts ;
	
	/usr/hdp/current/kafka-broker/bin/kafka-topics.sh \
	--create \
	--zookeeper $1 \
	--replication-factor 2 \
	--partitions 3 \
	--topic energy-mgmt ;	
	
	/usr/hdp/current/kafka-broker/bin/kafka-topics.sh \
	--create \
	--zookeeper $1 \
	--replication-factor 2 \
	--partitions 3 \
	--topic audit-events ;		
	
	/usr/hdp/current/kafka-broker/bin/kafka-topics.sh \
	--create \
	--zookeeper $1 \
	--replication-factor 2 \
	--partitions 3 \
	--topic compliance ;
	
	/usr/hdp/current/kafka-broker/bin/kafka-topics.sh \
	--create \
	--zookeeper $1 \
	--replication-factor 2 \
	--partitions 3 \
	--topic adjudication ;
	
	/usr/hdp/current/kafka-broker/bin/kafka-topics.sh \
	--create \
	--zookeeper $1 \
	--replication-factor 2 \
	--partitions 3 \
	--topic approval ;	
	
	/usr/hdp/current/kafka-broker/bin/kafka-topics.sh \
    --create \
    --zookeeper $1 \
    --replication-factor 2 \
    --partitions 3 \
    --topic driver-violation-events;	
    
     /usr/hdp/current/kafka-broker/bin/kafka-topics.sh \
    --create \
    --zookeeper $1 \
    --replication-factor 2 \
    --partitions 3 \
    --topic driver-average-speed;
    
     /usr/hdp/current/kafka-broker/bin/kafka-topics.sh \
    --create \
    --zookeeper $1 \
    --replication-factor 2 \
    --partitions 3 \
    --topic gateway-geo-raw-sensor;    
    
     /usr/hdp/current/kafka-broker/bin/kafka-topics.sh \
    --create \
    --zookeeper $1 \
    --replication-factor 2 \
    --partitions 3 \
    --topic gateway-speed-raw-sensor;      
       	
				
fi