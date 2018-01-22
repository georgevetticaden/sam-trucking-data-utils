package hortonworks.hdf.sam.refapp.trucking.simulator.impl.collectors;

import hortonworks.hdf.sam.refapp.trucking.simulator.impl.domain.transport.EventSourceType;
import hortonworks.hdf.sam.refapp.trucking.simulator.impl.domain.transport.MobileEyeEvent;
import hortonworks.hdf.sam.refapp.trucking.simulator.schemaregistry.TruckSchemaConfig;

import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import org.apache.kafka.clients.producer.Callback;
import org.apache.kafka.clients.producer.KafkaProducer;
import org.apache.kafka.clients.producer.ProducerRecord;
import org.apache.kafka.clients.producer.RecordMetadata;
import org.apache.kafka.common.header.Header;

public class KafkaCSVEventWithSchemaHeaderCollector extends BaseTruckEventCollector {


	
	private static final String SCHEMA_KAFKA_HEADER_KEY = "schema.name";
	private KafkaProducer<String, String> kafkaProducer;
	private EventSourceType eventSourceType;

	public KafkaCSVEventWithSchemaHeaderCollector(String kafkaBrokerList, EventSourceType eventSource) {
		this.eventSourceType = eventSource;
        Properties props = new Properties();
        props.put("bootstrap.servers", kafkaBrokerList);

        props.put("request.required.acks", "1");
        
        props.put("key.serializer", 
                "org.apache.kafka.common.serialization.StringSerializer");
                
             props.put("value.serializer", 
                "org.apache.kafka.common.serialization.StringSerializer");        
 
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
		String eventToPass = createTruckSpeedEvent(mee);
		String driverId = String.valueOf(mee.getTruck().getDriver().getDriverId());
		logger.debug("Creating truck geo event["+eventToPass+"] for driver["+mee.getTruck().getDriver().getDriverId() + "] in truck [" + mee.getTruck() + "]");	
		
		
		try {
			final Callback callback = new MyProducerCallback();
			Iterable<Header> kafkaHeaders = createKafkaHeaderWithSchema(TruckSchemaConfig.KAFKA_RAW_TRUCK_SPEED_EVENT_SCHEMA_NAME);
			ProducerRecord<String, String> data = new ProducerRecord<String, String>(TruckSchemaConfig.KAFKA_RAW_TRUCK_CSV_EVENT_TOPIC_NAME, null, driverId, eventToPass, kafkaHeaders);
			//logger.debug("Truck Speed Kafka Record with Header is: " + data);
			kafkaProducer.send(data, callback);			
		} catch (Exception e) {
			logger.error("Error sending csv geo event[" + eventToPass + "] to  Kafka topic["+TruckSchemaConfig.KAFKA_RAW_TRUCK_CSV_EVENT_TOPIC_NAME +"]", e);
		}		
		

	}

	private void sendTruckEventToKafka(MobileEyeEvent mee) {
		String eventToPass = createTruckGeoEvent(mee);
		String driverId = String.valueOf(mee.getTruck().getDriver().getDriverId());
		logger.debug("Creating  truck speed event["+eventToPass+"] for driver["+mee.getTruck().getDriver().getDriverId() + "] in truck [" + mee.getTruck() + "]");			
				
		try {
			final Callback callback = new MyProducerCallback();
			Iterable<Header> kafkaHeaders = createKafkaHeaderWithSchema(TruckSchemaConfig.KAFKA_RAW_TRUCK_GEO_EVENT_SCHEMA_NAME);
			ProducerRecord<String, String> data = new ProducerRecord<String, String>(TruckSchemaConfig.KAFKA_RAW_TRUCK_CSV_EVENT_TOPIC_NAME, null, driverId, eventToPass, kafkaHeaders);
			//logger.debug("Truck Geo Kafka Record with Header is: " + data);
			kafkaProducer.send(data, callback);			
		} catch (Exception e) {
			logger.error("Error sending csv speed event[" + eventToPass + "] to  Kafka topic["+TruckSchemaConfig.KAFKA_RAW_TRUCK_CSV_EVENT_TOPIC_NAME +"]", e);
		}		
		
		
	}
	
	private Iterable<Header> createKafkaHeaderWithSchema(
			String schema) {
		List<Header> headers = new ArrayList<Header>();
		Header schemaHeader = new SchemaKafkaHeader(SCHEMA_KAFKA_HEADER_KEY, schema);
		headers.add(schemaHeader);
		return headers;
	}	

	 private  class MyProducerCallback implements Callback {
	        @Override
	        public void onCompletion(RecordMetadata recordMetadata, Exception e) {
	           // logger.info("#### received [{}], ex: [{}]", recordMetadata, e);
	        }
	}	

		
}
