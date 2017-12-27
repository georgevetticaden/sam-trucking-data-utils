package hortonworks.hdf.sam.refapp.trucking.simulator.impl.domain.transport.route;

import hortonworks.hdf.sam.refapp.trucking.simulator.impl.domain.gps.Location;

import java.util.List;


public interface Route {
	List<Location> getLocations();
	Location getNextLocation();
	Location getStartingPoint();
	boolean routeEnded();
	int getRouteId();
	String getRouteName();
	
}