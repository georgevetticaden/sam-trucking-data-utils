#!/bin/bash

export JAVA_HOME=$(find /usr/jdk64 -iname 'jdk1.8*' -type d)
export PATH=$PATH:$JAVA_HOME/bin
export numOfInternational=30
export kafkaBrokers="a-summit11.field.hortonworks.com:6667,a-summit12.field.hortonworks.com:6667,a-summit13.field.hortonworks.com:6667,a-summit14.field.hortonworks.com:6667,a-summit15.field.hortonworks.com:6667"


createInternationalTrucks() {
	echo "----------------- Starting International Fleet  ----------------- "
	for ((i=1;i<=numOfInternational;i++)); do
	
		clientProducerId='europe-truck-i'$i
		logFile='i'$i'.out'
  		echo $clientProducerId
	
		nohup java -cp \
		stream-simulator-jar-with-dependencies.jar \
		hortonworks.hdf.sam.refapp.trucking.simulator.app.smm.SMMSimulationRunnerSingleDriverApp \
		-1 \
		hortonworks.hdf.sam.refapp.trucking.simulator.impl.domain.transport.Truck \
		hortonworks.hdf.sam.refapp.trucking.simulator.impl.collectors.smm.kafka.SMMTruckEventCSVGenerator \
		1 \
		/root/workspace/Data-Loader/routes/midwest/ \
		5000 \
		$kafkaBrokers \
		ALL_STREAMS \
		NONSECURE \
		$clientProducerId \
		gateway-international-raw-sensors \
		10 \
		"Saint Louis to Tulsa" \
		10 > $logFile &
	done
}

createUSFleet() {

echo "----------------- Starting US West Truck Fleet ----------------- "

nohup java -cp \
	stream-simulator-jar-with-dependencies.jar \
	hortonworks.hdf.sam.refapp.trucking.simulator.app.smm.SMMSimulationRunnerSingleDriverApp \
	-1 \
	hortonworks.hdf.sam.refapp.trucking.simulator.impl.domain.transport.Truck \
	hortonworks.hdf.sam.refapp.trucking.simulator.impl.collectors.smm.kafka.SMMTruckEventCSVGenerator \
	1 \
	/root/workspace/Data-Loader/routes/midwest/ \
	5000 \
	$kafkaBrokers \
	ALL_STREAMS \
	NONSECURE \
	minifi-truck-w1 \
	gateway-west-raw-sensors \
	10 \
	"Saint Louis to Tulsa" \
	10 > w1.out &

nohup java -cp \
	stream-simulator-jar-with-dependencies.jar \
	hortonworks.hdf.sam.refapp.trucking.simulator.app.smm.SMMSimulationRunnerSingleDriverApp \
	-1 \
	hortonworks.hdf.sam.refapp.trucking.simulator.impl.domain.transport.Truck \
	hortonworks.hdf.sam.refapp.trucking.simulator.impl.collectors.smm.kafka.SMMTruckEventCSVGenerator \
	1 \
	/root/workspace/Data-Loader/routes/midwest/ \
	5000 \
	$kafkaBrokers \
	ALL_STREAMS \
	NONSECURE \
	minifi-truck-w2 \
	gateway-west-raw-sensors \
	13 \
	"Des Moines to Chicago" \
	13 > w2.out &
	
nohup java -cp \
	stream-simulator-jar-with-dependencies.jar \
	hortonworks.hdf.sam.refapp.trucking.simulator.app.smm.SMMSimulationRunnerSingleDriverApp \
	-1 \
	hortonworks.hdf.sam.refapp.trucking.simulator.impl.domain.transport.Truck \
	hortonworks.hdf.sam.refapp.trucking.simulator.impl.collectors.smm.kafka.SMMTruckEventCSVGenerator \
	1 \
	/root/workspace/Data-Loader/routes/midwest/ \
	5000 \
	$kafkaBrokers \
	ALL_STREAMS \
	NONSECURE \
	minifi-truck-w3 \
	gateway-west-raw-sensors \
	14 \
	"Joplin to Kansas City" \
	14 > w3.out &
	
echo "----------------- Starting US Central Truck Fleet ----------------- "	
	nohup java -cp \
	stream-simulator-jar-with-dependencies.jar \
	hortonworks.hdf.sam.refapp.trucking.simulator.app.smm.SMMSimulationRunnerSingleDriverApp \
	-1 \
	hortonworks.hdf.sam.refapp.trucking.simulator.impl.domain.transport.Truck \
	hortonworks.hdf.sam.refapp.trucking.simulator.impl.collectors.smm.kafka.SMMTruckEventCSVGenerator \
	1 \
	/root/workspace/Data-Loader/routes/midwest/ \
	5000 \
	$kafkaBrokers \
	ALL_STREAMS \
	NONSECURE \
	minifi-truck-c1 \
	gateway-central-raw-sensors \
	11 \
	"Saint Louis to Chicago" \
	11 > c1.out &
	
nohup java -cp \
	stream-simulator-jar-with-dependencies.jar \
	hortonworks.hdf.sam.refapp.trucking.simulator.app.smm.SMMSimulationRunnerSingleDriverApp \
	-1 \
	hortonworks.hdf.sam.refapp.trucking.simulator.impl.domain.transport.Truck \
	hortonworks.hdf.sam.refapp.trucking.simulator.impl.collectors.smm.kafka.SMMTruckEventCSVGenerator \
	1 \
	/root/workspace/Data-Loader/routes/midwest/ \
	5000 \
	$kafkaBrokers \
	ALL_STREAMS \
	NONSECURE \
	minifi-truck-c2 \
	gateway-central-raw-sensors \
	15 \
	"Memphis to Little Rock" \
	15 > c2.out &
	
nohup java -cp \
	stream-simulator-jar-with-dependencies.jar \
	hortonworks.hdf.sam.refapp.trucking.simulator.app.smm.SMMSimulationRunnerSingleDriverApp \
	-1 \
	hortonworks.hdf.sam.refapp.trucking.simulator.impl.domain.transport.Truck \
	hortonworks.hdf.sam.refapp.trucking.simulator.impl.collectors.smm.kafka.SMMTruckEventCSVGenerator \
	1 \
	/root/workspace/Data-Loader/routes/midwest/ \
	5000 \
	$kafkaBrokers \
	ALL_STREAMS \
	NONSECURE \
	minifi-truck-c3 \
	gateway-central-raw-sensors \
	16 \
	"Peoria to Ceder Rapids" \
	16 > c3.out &
	
echo "----------------- Starting US East Truck Fleet ----------------- "	

nohup java -cp \
	stream-simulator-jar-with-dependencies.jar \
	hortonworks.hdf.sam.refapp.trucking.simulator.app.smm.SMMSimulationRunnerSingleDriverApp \
	-1 \
	hortonworks.hdf.sam.refapp.trucking.simulator.impl.domain.transport.Truck \
	hortonworks.hdf.sam.refapp.trucking.simulator.impl.collectors.smm.kafka.SMMTruckEventCSVGenerator \
	1 \
	/root/workspace/Data-Loader/routes/midwest/ \
	5000 \
	$kafkaBrokers \
	ALL_STREAMS \
	NONSECURE \
	minifi-truck-e1 \
	gateway-east-raw-sensors \
	12 \
	"Saint Louis to Memphis" \
	12 > e1.out &	
	
nohup java -cp \
	stream-simulator-jar-with-dependencies.jar \
	hortonworks.hdf.sam.refapp.trucking.simulator.app.smm.SMMSimulationRunnerSingleDriverApp \
	-1 \
	hortonworks.hdf.sam.refapp.trucking.simulator.impl.domain.transport.Truck \
	hortonworks.hdf.sam.refapp.trucking.simulator.impl.collectors.smm.kafka.SMMTruckEventCSVGenerator \
	1 \
	/root/workspace/Data-Loader/routes/midwest/ \
	5000 \
	$kafkaBrokers \
	ALL_STREAMS \
	NONSECURE \
	minifi-truck-e2 \
	gateway-east-raw-sensors \
	17 \
	"Springfield to KC Via Columbia" \
	17 > e2.out &
	

nohup java -cp \
	stream-simulator-jar-with-dependencies.jar \
	hortonworks.hdf.sam.refapp.trucking.simulator.app.smm.SMMSimulationRunnerSingleDriverApp \
	-1 \
	hortonworks.hdf.sam.refapp.trucking.simulator.impl.domain.transport.Truck \
	hortonworks.hdf.sam.refapp.trucking.simulator.impl.collectors.smm.kafka.SMMTruckEventCSVGenerator \
	1 \
	/root/workspace/Data-Loader/routes/midwest/ \
	5000 \
	$kafkaBrokers \
	ALL_STREAMS \
	NONSECURE \
	minifi-truck-e3 \
	gateway-east-raw-sensors \
	18 \
	"Des Moines to Chicago Route 2" \
	18 > e3.out &

}

createUSFleet;
createInternationalTrucks;

	


