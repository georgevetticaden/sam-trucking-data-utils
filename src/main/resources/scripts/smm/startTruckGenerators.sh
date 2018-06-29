#!/bin/bash

export JAVA_HOME=$(find /usr/jdk64 -iname 'jdk1.8*' -type d)
export PATH=$PATH:$JAVA_HOME/bin
export SIMULATOR_JAR=stream-simulator-jar-with-dependencies.jar

export kafkaBrokers="a-dps-connected-dp11.field.hortonworks.com:6667,a-dps-connected-dp12.field.hortonworks.com:6667,a-dps-connected-dp13.field.hortonworks.com:6667,a-dps-connected-dp14.field.hortonworks.com:6667,a-dps-connected-dp15.field.hortonworks.com:6667"
export SECURE_MODE=SECURE 
export JAAS_CONFIG=" -Djava.security.auth.login.config=simulator_jaas.conf "
export numOfEuropeTrucks=25
export numOfCriticalEventProducers=30


createEuropeTrucks() {
	echo "----------------- Starting International Fleet  ----------------- "
	for ((i=1;i<=numOfEuropeTrucks;i++)); do
	
		clientProducerId='minifi-eu-i'$i
		logFile='eu'$i'.out'
  		echo $clientProducerId
  		waitTime=$((i*2000));
	
		java  $JAAS_CONFIG -cp \
		$SIMULATOR_JAR \
		hortonworks.hdf.sam.refapp.trucking.simulator.app.smm.SMMSimulationRunnerTruckFleetApp \
		-1 \
		hortonworks.hdf.sam.refapp.trucking.simulator.impl.domain.transport.Truck \
		hortonworks.hdf.sam.refapp.trucking.simulator.impl.collectors.smm.kafka.SMMTruckEventCSVGenerator \
		1 \
		/root/workspace/Data-Loader/routes/midwest/ \
		$waitTime \
		$kafkaBrokers \
		ALL_STREAMS \
		$SECURE_MODE \
		$clientProducerId \
		gateway-europe-raw-sensors > $logFile &
	done
}

createAllGeoCriticalEventProducers() {
	echo "----------------- Starting Geo Event Critical Producers  ----------------- "
	for ((i=1;i<=numOfCriticalEventProducers;i++)); do
	
		clientProducerId='geo-critical-event-collector-i'$i
		logFile='geo-critical-event'$i'.out'
  		echo $clientProducerId
		waitTime=$((i*1000));
		
		java  $JAAS_CONFIG -cp \
		$SIMULATOR_JAR \
		hortonworks.hdf.sam.refapp.trucking.simulator.app.smm.SMMSimulationRunnerTruckFleetApp \
		-1 \
		hortonworks.hdf.sam.refapp.trucking.simulator.impl.domain.transport.Truck \
		hortonworks.hdf.sam.refapp.trucking.simulator.impl.collectors.smm.kafka.SMMTruckEventCSVGenerator \
		1 \
		/root/workspace/Data-Loader/routes/midwest/ \
		$waitTime \
		$kafkaBrokers \
		ALL_STREAMS \
		$SECURE_MODE \
		$clientProducerId \
		syndicate-all-geo-critical-events > $logFile &
	done
}


createMicroServiceProducers() {

	echo "----------------- Starting Mirco Service Producers  ----------------- "
	topics=(route-planning load-optimization fuel-logistics supply-chain predictive-alerts energy-mgmt audit-events compliance adjudication approval syndicate-oil syndicate-battery syndicate-transmission)
	apps=(route load-optimizer fuel supply-chain predictive energy audit compliance adjudication approval micro-service-oil micro-service-batter micro-service-transmissiony)
	i=0
	for topic in "${topics[@]}"
	do
    	topicName=$topic
        clientProducerId=${apps[i]}-apps
        logFile=$clientProducerId.out;
		waitTime=$((i*2150));
		
		java  $JAAS_CONFIG -cp \
		$SIMULATOR_JAR \
		hortonworks.hdf.sam.refapp.trucking.simulator.app.smm.SMMSimulationRunnerTruckFleetApp \
		-1 \
		hortonworks.hdf.sam.refapp.trucking.simulator.impl.domain.transport.Truck \
		hortonworks.hdf.sam.refapp.trucking.simulator.impl.collectors.smm.kafka.SMMTruckEventCSVGenerator \
		1 \
		/root/workspace/Data-Loader/routes/midwest/ \
		$waitTime \
		$kafkaBrokers \
		ALL_STREAMS \
		$SECURE_MODE \
		$clientProducerId \
		$topicName > $logFile &        
        
        i=$((i+1))
	done  	
}


createUSFleet() {

echo "----------------- Starting US West Truck Fleet ----------------- "

 java  $JAAS_CONFIG -cp \
	$SIMULATOR_JAR \
	hortonworks.hdf.sam.refapp.trucking.simulator.app.smm.SMMSimulationRunnerSingleDriverApp \
	-1 \
	hortonworks.hdf.sam.refapp.trucking.simulator.impl.domain.transport.Truck \
	hortonworks.hdf.sam.refapp.trucking.simulator.impl.collectors.smm.kafka.SMMTruckEventCSVGenerator \
	1 \
	/root/workspace/Data-Loader/routes/midwest/ \
	5000 \
	$kafkaBrokers \
	ALL_STREAMS \
	$SECURE_MODE \
	minifi-truck-w1 \
	gateway-west-raw-sensors \
	10 \
	"Saint Louis to Tulsa" \
	10 > w1.out &

 java  $JAAS_CONFIG -cp \
	$SIMULATOR_JAR \
	hortonworks.hdf.sam.refapp.trucking.simulator.app.smm.SMMSimulationRunnerSingleDriverApp \
	-1 \
	hortonworks.hdf.sam.refapp.trucking.simulator.impl.domain.transport.Truck \
	hortonworks.hdf.sam.refapp.trucking.simulator.impl.collectors.smm.kafka.SMMTruckEventCSVGenerator \
	1 \
	/root/workspace/Data-Loader/routes/midwest/ \
	6000 \
	$kafkaBrokers \
	ALL_STREAMS \
	$SECURE_MODE \
	minifi-truck-w2 \
	gateway-west-raw-sensors \
	13 \
	"Des Moines to Chicago" \
	13 > w2.out &
	
 java  $JAAS_CONFIG -cp \
	$SIMULATOR_JAR \
	hortonworks.hdf.sam.refapp.trucking.simulator.app.smm.SMMSimulationRunnerSingleDriverApp \
	-1 \
	hortonworks.hdf.sam.refapp.trucking.simulator.impl.domain.transport.Truck \
	hortonworks.hdf.sam.refapp.trucking.simulator.impl.collectors.smm.kafka.SMMTruckEventCSVGenerator \
	1 \
	/root/workspace/Data-Loader/routes/midwest/ \
	7000 \
	$kafkaBrokers \
	ALL_STREAMS \
	$SECURE_MODE \
	minifi-truck-w3 \
	gateway-west-raw-sensors \
	14 \
	"Joplin to Kansas City" \
	14 > w3.out &
	
echo "----------------- Starting US Central Truck Fleet ----------------- "	
	 java  $JAAS_CONFIG -cp \
	$SIMULATOR_JAR \
	hortonworks.hdf.sam.refapp.trucking.simulator.app.smm.SMMSimulationRunnerSingleDriverApp \
	-1 \
	hortonworks.hdf.sam.refapp.trucking.simulator.impl.domain.transport.Truck \
	hortonworks.hdf.sam.refapp.trucking.simulator.impl.collectors.smm.kafka.SMMTruckEventCSVGenerator \
	1 \
	/root/workspace/Data-Loader/routes/midwest/ \
	8000 \
	$kafkaBrokers \
	ALL_STREAMS \
	$SECURE_MODE \
	minifi-truck-c1 \
	gateway-central-raw-sensors \
	11 \
	"Saint Louis to Chicago" \
	11 > c1.out &
	
 java  $JAAS_CONFIG -cp \
	$SIMULATOR_JAR \
	hortonworks.hdf.sam.refapp.trucking.simulator.app.smm.SMMSimulationRunnerSingleDriverApp \
	-1 \
	hortonworks.hdf.sam.refapp.trucking.simulator.impl.domain.transport.Truck \
	hortonworks.hdf.sam.refapp.trucking.simulator.impl.collectors.smm.kafka.SMMTruckEventCSVGenerator \
	1 \
	/root/workspace/Data-Loader/routes/midwest/ \
	9000 \
	$kafkaBrokers \
	ALL_STREAMS \
	$SECURE_MODE \
	minifi-truck-c2 \
	gateway-central-raw-sensors \
	15 \
	"Memphis to Little Rock" \
	15 > c2.out &
	
 java  $JAAS_CONFIG -cp \
	$SIMULATOR_JAR \
	hortonworks.hdf.sam.refapp.trucking.simulator.app.smm.SMMSimulationRunnerSingleDriverApp \
	-1 \
	hortonworks.hdf.sam.refapp.trucking.simulator.impl.domain.transport.Truck \
	hortonworks.hdf.sam.refapp.trucking.simulator.impl.collectors.smm.kafka.SMMTruckEventCSVGenerator \
	1 \
	/root/workspace/Data-Loader/routes/midwest/ \
	10000 \
	$kafkaBrokers \
	ALL_STREAMS \
	$SECURE_MODE \
	minifi-truck-c3 \
	gateway-central-raw-sensors \
	16 \
	"Peoria to Ceder Rapids" \
	16 > c3.out &
	
echo "----------------- Starting US East Truck Fleet ----------------- "	

 java  $JAAS_CONFIG -cp \
	$SIMULATOR_JAR \
	hortonworks.hdf.sam.refapp.trucking.simulator.app.smm.SMMSimulationRunnerSingleDriverApp \
	-1 \
	hortonworks.hdf.sam.refapp.trucking.simulator.impl.domain.transport.Truck \
	hortonworks.hdf.sam.refapp.trucking.simulator.impl.collectors.smm.kafka.SMMTruckEventCSVGenerator \
	1 \
	/root/workspace/Data-Loader/routes/midwest/ \
	11000 \
	$kafkaBrokers \
	ALL_STREAMS \
	$SECURE_MODE \
	minifi-truck-e1 \
	gateway-east-raw-sensors \
	12 \
	"Saint Louis to Memphis" \
	12 > e1.out &	
	
 java  $JAAS_CONFIG -cp \
	$SIMULATOR_JAR \
	hortonworks.hdf.sam.refapp.trucking.simulator.app.smm.SMMSimulationRunnerSingleDriverApp \
	-1 \
	hortonworks.hdf.sam.refapp.trucking.simulator.impl.domain.transport.Truck \
	hortonworks.hdf.sam.refapp.trucking.simulator.impl.collectors.smm.kafka.SMMTruckEventCSVGenerator \
	1 \
	/root/workspace/Data-Loader/routes/midwest/ \
	12000 \
	$kafkaBrokers \
	ALL_STREAMS \
	$SECURE_MODE \
	minifi-truck-e2 \
	gateway-east-raw-sensors \
	17 \
	"Springfield to KC Via Columbia" \
	17 > e2.out &
	

 java  $JAAS_CONFIG -cp \
	$SIMULATOR_JAR \
	hortonworks.hdf.sam.refapp.trucking.simulator.app.smm.SMMSimulationRunnerSingleDriverApp \
	-1 \
	hortonworks.hdf.sam.refapp.trucking.simulator.impl.domain.transport.Truck \
	hortonworks.hdf.sam.refapp.trucking.simulator.impl.collectors.smm.kafka.SMMTruckEventCSVGenerator \
	1 \
	/root/workspace/Data-Loader/routes/midwest/ \
	13000 \
	$kafkaBrokers \
	ALL_STREAMS \
	$SECURE_MODE \
	minifi-truck-e3 \
	gateway-east-raw-sensors \
	18 \
	"Des Moines to Chicago Route 2" \
	18 > e3.out &

}

createUSFleet;
createEuropeTrucks;
createMicroServiceProducers;
createAllGeoCriticalEventProducers;

	


