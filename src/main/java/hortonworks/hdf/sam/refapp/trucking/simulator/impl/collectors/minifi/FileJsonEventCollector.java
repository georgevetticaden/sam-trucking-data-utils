package hortonworks.hdf.sam.refapp.trucking.simulator.impl.collectors.minifi;

import hortonworks.hdf.sam.refapp.trucking.simulator.impl.collectors.BaseTruckEventCollector;
import hortonworks.hdf.sam.refapp.trucking.simulator.impl.collectors.TruckGeoEvent;
import hortonworks.hdf.sam.refapp.trucking.simulator.impl.collectors.TruckSpeedEvent;
import hortonworks.hdf.sam.refapp.trucking.simulator.impl.domain.transport.EventSourceType;
import hortonworks.hdf.sam.refapp.trucking.simulator.impl.domain.transport.MobileEyeEvent;
import hortonworks.hdf.sam.refapp.trucking.simulator.impl.domain.transport.Truck;

import java.io.File;
import java.nio.charset.Charset;
import java.sql.Timestamp;
import java.util.Date;

import org.apache.commons.io.FileUtils;

import com.fasterxml.jackson.databind.ObjectMapper;


public class FileJsonEventCollector extends BaseTruckEventCollector {


	private static final String LINE_BREAK = "\n";
	private File truckEventsFile;
	private EventSourceType eventSourceType;

	public FileJsonEventCollector(String fileName) {
       this.truckEventsFile = new File(fileName);
      
	}
	
	public FileJsonEventCollector(String fileName, EventSourceType eventSource) {
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
		
		//String eventToPass = createTruckGeoEvent(mee) +"|" + LINE_BREAK;
		String eventToPass = createTruckGeoEventJsonString(mee) + LINE_BREAK;
		logger.debug("Creating truck geo event["+eventToPass+"] for driver["+mee.getTruck().getDriver().getDriverId() + "] in truck [" + mee.getTruck() + "]");	
		
			
		try {
			FileUtils.writeStringToFile(truckEventsFile, eventToPass, Charset.defaultCharset(), true);
		} catch (Exception e) {
			logger.error("Error sending event[" + eventToPass + "] to file[ " + truckEventsFile + " ] ", e);
		}		
		
	}

	private void sendTruckSpeedEventToFile(MobileEyeEvent mee) {
		
		//String eventToPass = createTruckSpeedEvent(mee) + "|" + LINE_BREAK;
		String eventToPass = createTruckSpeedEventJsonString(mee) + LINE_BREAK;;
		logger.debug("Creating truck speed event["+eventToPass+"] for driver["+mee.getTruck().getDriver().getDriverId() + "] in truck [" + mee.getTruck() + "]");
				
		
		
		try {
			FileUtils.writeStringToFile(truckEventsFile, eventToPass, Charset.defaultCharset(), true);
		} catch (Exception e) {
			logger.error("Error sending event[" + eventToPass + "] to file[ " + truckEventsFile + " ] ", e);
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

}
