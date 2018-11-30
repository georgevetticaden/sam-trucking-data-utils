package hortonworks.hdf.sam.refapp.trucking.simulator.impl.collectors;

import hortonworks.hdf.sam.refapp.trucking.simulator.impl.domain.AbstractEventCollector;
import hortonworks.hdf.sam.refapp.trucking.simulator.impl.domain.transport.MobileEyeEvent;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.TimeZone;

public abstract class BaseTruckEventCollector extends AbstractEventCollector {

	
	protected String createTruckGeoEvent(MobileEyeEvent mee) {
		long eventTimeLong = new Date().getTime();        
         
        SimpleDateFormat dateFormatGmt = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS");
        dateFormatGmt.setTimeZone(TimeZone.getTimeZone("GMT"));
        
        String eventTime = dateFormatGmt.format(new Date(eventTimeLong));
        
		String eventToPass =  eventTime + "|" + eventTimeLong + "|truck_geo_event|"  + mee.toString();
		return eventToPass;
	}	
	
	protected String createTruckSpeedEvent(MobileEyeEvent mee) {
		
		long eventTimeLong = new Date().getTime();        
        
        SimpleDateFormat dateFormatGmt = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS");
        dateFormatGmt.setTimeZone(TimeZone.getTimeZone("GMT"));
        
        String eventTime = dateFormatGmt.format(new Date(eventTimeLong));
        
		String eventToPass = eventTime + "|" +eventTimeLong + "|truck_speed_event|" + mee.getTruck().toString() + "|" + mee.getTruckSpeed();
		return eventToPass;
	}		
	
//	protected String createTruckSpeedEvent(MobileEyeEvent mee) {
//		
//        long eventTimeLong = new Date().getTime();
//        String eventTime = new Timestamp(eventTimeLong).toString();
//        
//        
//		String eventToPass = eventTime + "|" +eventTimeLong + "|truck_speed_event|" + mee.getTruck().toString() + "|" + mee.getTruckSpeed();
//		return eventToPass;
//	}
	

	
//	protected String createTruckGeoEvent(MobileEyeEvent mee) {
//        long eventTimeLong = new Date().getTime();
//        String eventTime = new Timestamp(eventTimeLong).toString();
//        
//		String eventToPass =  eventTime + "|" + eventTimeLong + "|truck_geo_event|"  + mee.toString();
//		return eventToPass;
//	}	

	

}
