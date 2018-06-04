package hortonworks.hdf.sam.refapp.trucking.simulator.impl.collectors;

import hortonworks.hdf.sam.refapp.trucking.simulator.impl.domain.SecurityType;
import hortonworks.hdf.sam.refapp.trucking.simulator.impl.domain.transport.EventSourceType;
import hortonworks.hdf.sam.refapp.trucking.simulator.impl.domain.transport.MobileEyeEvent;
import hortonworks.hdf.sam.refapp.trucking.simulator.impl.domain.transport.Truck;
import hortonworks.hdf.sam.refapp.trucking.simulator.schemaregistry.TruckSchemaConfig;

import java.sql.Timestamp;
import java.util.Date;
import java.util.Properties;

import org.apache.kafka.clients.CommonClientConfigs;
import org.apache.kafka.clients.producer.Callback;
import org.apache.kafka.clients.producer.KafkaProducer;
import org.apache.kafka.clients.producer.ProducerRecord;
import org.apache.kafka.clients.producer.RecordMetadata;
import org.apache.kafka.common.header.Header;

import com.fasterxml.jackson.databind.ObjectMapper;




public class KafkaJsonEventCollector extends BaseTruckEventCollector {

	private static final String TRUCK_EVENT_TOPIC = "truck_events_json";
	private static final String TRUCK_SPEED_EVENT_TOPIC = "truck_speed_events_json";
	
	private KafkaProducer<String, String> kafkaProducer;
	private EventSourceType eventSourceType;

	public KafkaJsonEventCollector(String kafkaBrokerList, EventSourceType eventSource, SecurityType securityType) {
		this.eventSourceType = eventSource;
        Properties props = new Properties();
        props.put("bootstrap.servers", kafkaBrokerList);

        props.put("acks", "1");
        
        props.put("key.serializer", 
                "org.apache.kafka.common.serialization.StringSerializer");
                
        props.put("value.serializer", 
                "org.apache.kafka.common.serialization.StringSerializer");   
        
        props.put(CommonClientConfigs.CLIENT_ID_CONFIG, "truck-sensors-producer-json");
        
		 
        /* If talking to secure Kafka cluster, set security protocol as "SASL_PLAINTEXT */
		if(SecurityType.SECURE.equals(securityType)) {
		 	props.put(CommonClientConfigs.SECURITY_PROTOCOL_CONFIG, "SASL_PLAINTEXT");  
		 	props.put("sasl.kerberos.service.name", "kafka");

		}
 
        try {		
            kafkaProducer = new KafkaProducer<String, String>(props);        	
        } catch (Exception e) {
        	logger.error("Error creating producer" , e);
        }
      
	}
	
	@Override
	public void onReceive(Object event) throws Exception {
		MobileEyeEvent mee = (MobileEyeEvent) event;
		
		if(eventSourceType == null || EventSourceType.ALL_STREAMS.equals(eventSourceType)) {
			sendTruckEventToKafka(mee);	
			sendTruckSpeedEventToKafka(mee);	
		} else if(EventSourceType.GEO_EVENT_STREAM.equals(eventSourceType)) {
			sendTruckEventToKafka(mee);	
		} else if (EventSourceType.SPEED_STREAM.equals(eventSourceType)) {	
			sendTruckSpeedEventToKafka(mee);
		}
	

	}

	private void sendTruckSpeedEventToKafka(MobileEyeEvent mee) {
		
		String eventToPass = createTruckSpeedEventJsonString(mee);
		logger.debug("Creating truck speed event["+eventToPass+"] for driver["+mee.getTruck().getDriver().getDriverId() + "] in truck [" + mee.getTruck() + "]");
		
		String driverId = String.valueOf(mee.getTruck().getDriver().getDriverId());		
		
		try {

			final Callback callback = new MyProducerCallback();
			ProducerRecord<String, String> data = new ProducerRecord<String, String>(TRUCK_SPEED_EVENT_TOPIC, driverId, eventToPass);
			kafkaProducer.send(data, callback);				
			
		} catch (Exception e) {
			logger.error("Error sending event[" + eventToPass + "] to Kafka topic", e);
		}		
		
	}
	


	
	

	private void sendTruckEventToKafka(MobileEyeEvent mee) {
		String eventToPass = createTruckGeoEventJsonString(mee);
		logger.debug("Creating truck event["+eventToPass+"] for driver["+mee.getTruck().getDriver().getDriverId() + "] in truck [" + mee.getTruck() + "]");	
		
		String driverId = String.valueOf(mee.getTruck().getDriver().getDriverId());
		
		try {			
			final Callback callback = new MyProducerCallback();
			ProducerRecord<String, String> data = new ProducerRecord<String, String>(TRUCK_EVENT_TOPIC, driverId, eventToPass);
			kafkaProducer.send(data, callback);				
			
		} catch (Exception e) {
			logger.error("Error sending event[" + eventToPass + "] to Kafka topic", e);
		}
	}

	
	private String createTruckSpeedEventJsonString(MobileEyeEvent mee) {
		
		
		
		TruckSpeedEvent speedEvent = new TruckSpeedEvent();
		long eventTimeLong = new Date().getTime();
		String eventTime =  new Timestamp(eventTimeLong).toString();
		speedEvent.setEventTime(eventTime);
		speedEvent.setEventTimeLong(eventTimeLong);
		speedEvent.setEventSource("truck_speed_event");
		
		Truck truck = mee.getTruck();
		speedEvent.setTruckId(truck.getTruckId());
		speedEvent.setDriverId(truck.getDriver().getDriverId());;
		speedEvent.setDriverName(truck.getDriver().getDriverName());
		speedEvent.setRouteId(truck.getDriver().getRoute().getRouteId());
		speedEvent.setRoute(truck.getDriver().getRoute().getRouteName());
		
		speedEvent.setSpeed(mee.getTruckSpeed());
		
		String eventToPass = "";
		try {
			eventToPass =  new ObjectMapper().writeValueAsString(speedEvent);
		} catch (Exception e) {
			logger.error("error converting object to json" , e);
		}
		
		
		return eventToPass;
		
	}
	
	private String createTruckGeoEventJsonString(MobileEyeEvent mee) {
		
		
		
		TruckGeoEvent geoEvent = new TruckGeoEvent();
		long eventTimeLong = new Date().getTime();
		String eventTime =  new Timestamp(eventTimeLong).toString();
		geoEvent.setEventTime(eventTime);
		geoEvent.setEventTimeLong(eventTimeLong);
		geoEvent.setEventSource("truck_geo_event");
		
		Truck truck = mee.getTruck();
		geoEvent.setTruckId(truck.getTruckId());
		geoEvent.setDriverId(truck.getDriver().getDriverId());;
		geoEvent.setDriverName(truck.getDriver().getDriverName());
		geoEvent.setRouteId(truck.getDriver().getRoute().getRouteId());
		geoEvent.setRoute(truck.getDriver().getRoute().getRouteName());
		
		geoEvent.setEventType(mee.getEventType().toString());
		geoEvent.setLongitude(mee.getLocation().getLongitude());
		geoEvent.setLatitude(mee.getLocation().getLatitude());
		geoEvent.setCorrelationId(mee.getCorrelationId());

		
		String eventToPass = "";
		try {
			eventToPass =  new ObjectMapper().writeValueAsString(geoEvent);
		} catch (Exception e) {
			logger.error("error converting object to json" , e);
		}
		return eventToPass;
		
	}	
	
	 private  class MyProducerCallback implements Callback {
	        @Override
	        public void onCompletion(RecordMetadata recordMetadata, Exception e) {
	        	if(e != null) {
	        		if(recordMetadata == null) {
	        			logger.info("Exception thrown when sending message: " + e);
	        		} else {
	        			logger.info("Exception thrown when sending message: " + recordMetadata.toString() , e);
	        		}
	        	} else {
	        		logger.info(recordMetadata.toString());
	        	}
	        }
	}	
	

}
