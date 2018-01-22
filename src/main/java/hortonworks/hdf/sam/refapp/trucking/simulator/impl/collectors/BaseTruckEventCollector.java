package hortonworks.hdf.sam.refapp.trucking.simulator.impl.collectors;

import hortonworks.hdf.sam.refapp.trucking.simulator.impl.domain.AbstractEventCollector;
import hortonworks.hdf.sam.refapp.trucking.simulator.impl.domain.transport.MobileEyeEvent;

import java.sql.Timestamp;
import java.util.Date;

public abstract class BaseTruckEventCollector extends AbstractEventCollector {

	protected String createTruckSpeedEvent(MobileEyeEvent mee) {
		
        long eventTimeLong = new Date().getTime();
        String eventTime = new Timestamp(eventTimeLong).toString();
        
        
		String eventToPass = eventTime + "|" +eventTimeLong + "|truck_speed_event|" + mee.getTruck().toString() + "|" + mee.getTruckSpeed();
		return eventToPass;
	}
	
	protected String createTruckGeoEvent(MobileEyeEvent mee) {
        long eventTimeLong = new Date().getTime();
        String eventTime = new Timestamp(eventTimeLong).toString();
        
		String eventToPass =  eventTime + "|" + eventTimeLong + "|truck_geo_event|"  + mee.toString();
		return eventToPass;
	}	
	

}
