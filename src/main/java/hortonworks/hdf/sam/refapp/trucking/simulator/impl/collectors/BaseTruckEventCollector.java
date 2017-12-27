package hortonworks.hdf.sam.refapp.trucking.simulator.impl.collectors;

import hortonworks.hdf.sam.refapp.trucking.simulator.impl.domain.AbstractEventCollector;
import hortonworks.hdf.sam.refapp.trucking.simulator.impl.domain.transport.MobileEyeEvent;

import java.sql.Timestamp;
import java.util.Date;

public abstract class BaseTruckEventCollector extends AbstractEventCollector {

	protected String createTruckSpeedEvent(MobileEyeEvent mee) {
		String eventToPass = new Timestamp(new Date().getTime()) + "|truck_speed_event|" + mee.getTruck().toString() + "|" + mee.getTruckSpeed();
		return eventToPass;
	}
	
	protected String createTruckGeoEvent(MobileEyeEvent mee) {
		String eventToPass = new Timestamp(new Date().getTime()) + "|truck_geo_event|"  + mee.toString();
		return eventToPass;
	}	
	

}
