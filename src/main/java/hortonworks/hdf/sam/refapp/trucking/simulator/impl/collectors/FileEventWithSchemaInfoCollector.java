package hortonworks.hdf.sam.refapp.trucking.simulator.impl.collectors;

import hortonworks.hdf.sam.refapp.trucking.simulator.impl.domain.transport.EventSourceType;
import hortonworks.hdf.sam.refapp.trucking.simulator.impl.domain.transport.MobileEyeEvent;
import hortonworks.hdf.sam.refapp.trucking.simulator.schemaregistry.TruckSchemaConfig;

import java.io.File;
import java.nio.charset.Charset;

import org.apache.commons.io.FileUtils;


public class FileEventWithSchemaInfoCollector extends BaseTruckEventCollector {


	private static final String LINE_BREAK = "\n";
	
	private static final String SCHEMA_GROUP_DELIMITER = "<schema-group>";
	private static final String SCHEMA_NAME_DELIMITER = "<schema-name>";
	private static final String SCHEMA_VERSION_DELIMITER = "<schema-version>";

	
	private File truckEventsFile;

	private EventSourceType eventSourceType;

	public FileEventWithSchemaInfoCollector(String fileName,EventSourceType eventSource) {
       this.truckEventsFile = new File(fileName);
       this.eventSourceType = eventSource;
      
	}
	
	@Override
	public void onReceive(Object event) throws Exception {
		MobileEyeEvent mee = (MobileEyeEvent) event;
		
		if(eventSourceType == null || EventSourceType.ALL_STREAMS.equals(eventSourceType)) {
			sendTruckEventToFile(mee);	
			sendTruckSpeedEventToFile(mee);			
		} else if(EventSourceType.GEO_EVENT_STREAM.equals(eventSourceType)) {
			sendTruckEventToFile(mee);
		} else if (EventSourceType.SPEED_STREAM.equals(eventSourceType)) {
			sendTruckSpeedEventToFile(mee);	
		}

	}

	private void sendTruckEventToFile(MobileEyeEvent mee) {
		
		String eventToPass = createTruckGeoEvent(mee) +"|" + LINE_BREAK;
		String eventToPassWithSchema = addSchemaInfo(TruckSchemaConfig.LOG_SCHEMA_GROUP_NAME, TruckSchemaConfig.LOG_TRUCK_GEO_EVENT_SCHEMA_NAME, 
											TruckSchemaConfig.LOG_TRUCK_GEO_EVENT_SCHEMA_VERSION, eventToPass);
		logger.debug("Creating truck geo event["+eventToPassWithSchema+"] for driver["+mee.getTruck().getDriver().getDriverId() + "] in truck [" + mee.getTruck() + "]");
		
		try {
			FileUtils.writeStringToFile(truckEventsFile, eventToPassWithSchema, Charset.defaultCharset(), true);
		} catch (Exception e) {
			logger.error("Error sending event[" + eventToPassWithSchema + "] to file[ " + truckEventsFile + " ] ", e);
		}		
		
	}



	private void sendTruckSpeedEventToFile(MobileEyeEvent mee) {
		
		String eventToPass = createTruckSpeedEvent(mee) + "|" + LINE_BREAK;
		String eventToPassWithSchema = addSchemaInfo(TruckSchemaConfig.LOG_SCHEMA_GROUP_NAME, TruckSchemaConfig.LOG_TRUCK_SPEED_EVENT_SCHEMA_NAME, 
											TruckSchemaConfig.LOG_TRUCK_SPEED_EVENT_SCHEMA_VERSION, eventToPass);
		logger.debug("Creating speed event["+eventToPassWithSchema+"] for driver["+mee.getTruck().getDriver().getDriverId() + "] in truck [" + mee.getTruck() + "]");	
		
		try {
			FileUtils.writeStringToFile(truckEventsFile, eventToPassWithSchema, Charset.defaultCharset(), true);
		} catch (Exception e) {
			logger.error("Error sending event[" + eventToPassWithSchema + "] to file[ " + truckEventsFile + " ] ", e);
		}	
	}

	
	private String addSchemaInfo(String schemaGroup, String schemaName, int schemaVersion, String event) {
		StringBuffer buffer = new StringBuffer();
		buffer.append(SCHEMA_GROUP_DELIMITER)
			  .append(schemaGroup)
			  .append(SCHEMA_GROUP_DELIMITER)
			  .append(SCHEMA_NAME_DELIMITER)
			  .append(schemaName)
			  .append(SCHEMA_NAME_DELIMITER)
			  .append(SCHEMA_VERSION_DELIMITER)
			  .append(schemaVersion)
			  .append(SCHEMA_VERSION_DELIMITER)
			  .append("|")
			  .append(event);
		return buffer.toString();
	}	
		
	
}
