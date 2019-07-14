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
	--topic alerts-speeding-drivers;
	
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
	--topic fleet-supply-chain;	
	
	/usr/hdf/current/kafka-broker/bin/kafka-topics.sh \
	--create \
	--zookeeper $1 \
	--replication-factor 2 \
	--partitions 3 \
	--topic route-planning ;	
	
	/usr/hdf/current/kafka-broker/bin/kafka-topics.sh \
	--create \
	--zookeeper $1 \
	--replication-factor 2 \
	--partitions 3 \
	--topic load-optimization ;		
	
	/usr/hdf/current/kafka-broker/bin/kafka-topics.sh \
	--create \
	--zookeeper $1 \
	--replication-factor 2 \
	--partitions 3 \
	--topic fuel-logistics ;
	
	/usr/hdf/current/kafka-broker/bin/kafka-topics.sh \
	--create \
	--zookeeper $1 \
	--replication-factor 2 \
	--partitions 3 \
	--topic supply-chain ;	
	
	/usr/hdf/current/kafka-broker/bin/kafka-topics.sh \
	--create \
	--zookeeper $1 \
	--replication-factor 2 \
	--partitions 3 \
	--topic predictive-alerts ;
	
	/usr/hdf/current/kafka-broker/bin/kafka-topics.sh \
	--create \
	--zookeeper $1 \
	--replication-factor 2 \
	--partitions 3 \
	--topic energy-mgmt ;	
	
	/usr/hdf/current/kafka-broker/bin/kafka-topics.sh \
	--create \
	--zookeeper $1 \
	--replication-factor 2 \
	--partitions 3 \
	--topic audit-events ;		
	
	/usr/hdf/current/kafka-broker/bin/kafka-topics.sh \
	--create \
	--zookeeper $1 \
	--replication-factor 2 \
	--partitions 3 \
	--topic compliance ;
	
	/usr/hdf/current/kafka-broker/bin/kafka-topics.sh \
	--create \
	--zookeeper $1 \
	--replication-factor 2 \
	--partitions 3 \
	--topic adjudication ;
	
	/usr/hdf/current/kafka-broker/bin/kafka-topics.sh \
	--create \
	--zookeeper $1 \
	--replication-factor 2 \
	--partitions 3 \
	--topic approval ;	
	
	/usr/hdf/current/kafka-broker/bin/kafka-topics.sh \
    --create \
    --zookeeper $1 \
    --replication-factor 2 \
    --partitions 3 \
    --topic driver-violation-events;	
    
     /usr/hdf/current/kafka-broker/bin/kafka-topics.sh \
    --create \
    --zookeeper $1 \
    --replication-factor 2 \
    --partitions 3 \
    --topic driver-average-speed;
    
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
    
       /usr/hdf/current/kafka-broker/bin/kafka-topics.sh \
        --create \
        --zookeeper $1 \
        --replication-factor 2 \
        --partitions 3 \
        --topic gateway-freightliner-sensors;

        /usr/hdf/current/kafka-broker/bin/kafka-topics.sh \
        --create \
        --zookeeper $1 \
        --replication-factor 2 \
        --partitions 3 \
        --topic gateway-tata-sensors;

        /usr/hdf/current/kafka-broker/bin/kafka-topics.sh \
        --create \
        --zookeeper $1 \
        --replication-factor 2 \
        --partitions 3 \
        --topic gateway-mack-sensors;

        /usr/hdf/current/kafka-broker/bin/kafka-topics.sh \
        --create \
        --zookeeper $1 \
        --replication-factor 2 \
        --partitions 3 \
        --topic gateway-benz-sensors;

        /usr/hdf/current/kafka-broker/bin/kafka-topics.sh \
        --create \
        --zookeeper $1 \
        --replication-factor 2 \
        --partitions 3 \
        --topic syndicate-tata-speed;

        /usr/hdf/current/kafka-broker/bin/kafka-topics.sh \
        --create \
        --zookeeper $1 \
        --replication-factor 2 \
        --partitions 3 \
        --topic syndicate-tata-geo;

        /usr/hdf/current/kafka-broker/bin/kafka-topics.sh \
        --create \
        --zookeeper $1 \
        --replication-factor 2 \
        --partitions 3 \
        --topic syndicate-mack-speed;
        

        /usr/hdf/current/kafka-broker/bin/kafka-topics.sh \
        --create \
        --zookeeper $1 \
        --replication-factor 2 \
        --partitions 3 \
        --topic syndicate-mack-geo;

        /usr/hdf/current/kafka-broker/bin/kafka-topics.sh \
        --create \
        --zookeeper $1 \
        --replication-factor 2 \
        --partitions 3 \
        --topic syndicate-freightliner-speed;

        /usr/hdf/current/kafka-broker/bin/kafka-topics.sh \
        --create \
        --zookeeper $1 \
        --replication-factor 2 \
        --partitions 3 \
        --topic syndicate-freightliner-geo;

        /usr/hdf/current/kafka-broker/bin/kafka-topics.sh \
        --create \
        --zookeeper $1 \
        --replication-factor 2 \
        --partitions 3 \
        --topic syndicate-benz-speed;

        /usr/hdf/current/kafka-broker/bin/kafka-topics.sh \
        --create \
        --zookeeper $1 \
        --replication-factor 2 \
        --partitions 3 \
        --topic syndicate-benz-geo;
       	
				
fi