package hortonworks.hdf.sam.refapp.trucking.simulator.app.smm;

import hortonworks.hdf.sam.refapp.trucking.simulator.impl.domain.SecurityType;
import hortonworks.hdf.sam.refapp.trucking.simulator.impl.domain.transport.EventSourceType;
import hortonworks.hdf.sam.refapp.trucking.simulator.impl.domain.transport.TruckConfiguration;
import hortonworks.hdf.sam.refapp.trucking.simulator.impl.messages.StartSimulation;
import hortonworks.hdf.sam.refapp.trucking.simulator.listeners.SimulatorListener;
import hortonworks.hdf.sam.refapp.trucking.simulator.masters.SimulationMaster;
import akka.actor.ActorRef;
import akka.actor.ActorSystem;
import akka.actor.Props;
import akka.actor.UntypedActor;
import akka.actor.UntypedActorFactory;

public class SMMSimulationRunnerTruckFleetApp {
	public static void main(String[] args) {
			try {
				
				final int numberOfEvents = Integer.parseInt(args[0]);	
				final Class eventEmitterClass = Class.forName(args[1]);
				final Class eventCollectorClass = Class.forName(args[2]);
				final long demoId = Long.parseLong(args[3]);				
				String routesDirectory = args[4];
				final int delayBetweenEvents = Integer.valueOf(args[5]);
				String kafkaBrokerList = args[6];
				String eventSourceString = args[7];
				EventSourceType eventSource = EventSourceType.valueOf(eventSourceString);
				
				String securityTypeStrig = args[8];
				SecurityType securityType = SecurityType.valueOf(securityTypeStrig);				
				
				/* The producer name to cofigure for Kafka */
				String producerName = args[9];
				
				/* The kafka topic name to send events to */
				String topicName = args[10];
				
							
				TruckConfiguration.initialize(routesDirectory);
				
				/* Setting this all trucks avaialble */
				final int numberOfEventEmitters=TruckConfiguration.freeRoutePool.size();
		

				ActorSystem system = ActorSystem.create("EventSimulator");
				
				final ActorRef listener = system.actorOf(
						Props.create(SimulatorListener.class), "listener");
				final ActorRef eventCollector = system.actorOf(
						Props.create(eventCollectorClass, kafkaBrokerList, producerName, topicName, eventSource, securityType), "eventCollector");
				System.out.println(eventCollector.path());
				
				
				final ActorRef master = system.actorOf(new Props(
						new UntypedActorFactory() {
							public UntypedActor create() {
								return new SimulationMaster(
										numberOfEventEmitters,
										eventEmitterClass, listener, numberOfEvents, demoId, delayBetweenEvents);
							}
						}), "master");
				
				master.tell(new StartSimulation(), master);
			} catch (NumberFormatException e) {
				System.err.println("Invalid number of emitters: "
						+ e.getMessage());
			} catch (ClassNotFoundException e) {
				System.err.println("Cannot find classname: " + e.getMessage());
			}
		
	}
}
