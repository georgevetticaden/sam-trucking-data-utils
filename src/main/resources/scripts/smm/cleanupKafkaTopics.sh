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
	/usr/hdp/current/kafka-broker/bin/kafka-topics.sh --zookeeper $1 --topic syndicate-all-geo-critical-events --delete ;
	/usr/hdp/current/kafka-broker/bin/kafka-topics.sh --zookeeper $1 --topic syndicate-battery --delete ;
	/usr/hdp/current/kafka-broker/bin/kafka-topics.sh --zookeeper $1 --topic syndicate-oil --delete ;
	/usr/hdp/current/kafka-broker/bin/kafka-topics.sh --zookeeper $1 --topic syndicate-transmission --delete ;
	/usr/hdp/current/kafka-broker/bin/kafka-topics.sh --zookeeper $1 --topic fleet-supply-chain --delete ;
	/usr/hdp/current/kafka-broker/bin/kafka-topics.sh --zookeeper $1 --topic route-planning --delete ;
	/usr/hdp/current/kafka-broker/bin/kafka-topics.sh --zookeeper $1 --topic load-optimization --delete ;
	/usr/hdp/current/kafka-broker/bin/kafka-topics.sh --zookeeper $1 --topic fuel-logistics --delete ;
	/usr/hdp/current/kafka-broker/bin/kafka-topics.sh --zookeeper $1 --topic supply-chain --delete ;
	/usr/hdp/current/kafka-broker/bin/kafka-topics.sh --zookeeper $1 --topic predictive-alerts --delete ;
	/usr/hdp/current/kafka-broker/bin/kafka-topics.sh --zookeeper $1 --topic energy-mgmt --delete ;
	/usr/hdp/current/kafka-broker/bin/kafka-topics.sh --zookeeper $1 --topic audit-events --delete ;
	/usr/hdp/current/kafka-broker/bin/kafka-topics.sh --zookeeper $1 --topic compliance --delete ;
	/usr/hdp/current/kafka-broker/bin/kafka-topics.sh --zookeeper $1 --topic adjudication --delete ;
	/usr/hdp/current/kafka-broker/bin/kafka-topics.sh --zookeeper $1 --topic approval --delete ;
	
	
fi
