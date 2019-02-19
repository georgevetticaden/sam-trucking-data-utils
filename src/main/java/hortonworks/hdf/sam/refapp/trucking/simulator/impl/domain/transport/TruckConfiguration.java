package hortonworks.hdf.sam.refapp.trucking.simulator.impl.domain.transport;

import hortonworks.hdf.sam.refapp.trucking.simulator.datagenerator.DataGeneratorUtils;
import hortonworks.hdf.sam.refapp.trucking.simulator.impl.domain.transport.route.Route;
import hortonworks.hdf.sam.refapp.trucking.simulator.impl.domain.transport.route.RouteProvided;
import hortonworks.hdf.sam.refapp.trucking.simulator.impl.domain.transport.route.TruckRoutesParser;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentLinkedQueue;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class TruckConfiguration {

	private static Logger LOGGER = LoggerFactory.getLogger(TruckConfiguration.class);

	public static final long END_ROUTE_AFTER_METERS = 120000; // 75 miles
	private static final int TRUCK_FLEET_SIZE=1000;	
	private static final int TRUCK_ID_START = 10;
	public static final int MAX_ROUTE_TRAVERSAL_COUNT = 10;
	
	private static Map<Integer, Driver> drivers;
	public static ConcurrentLinkedQueue<Integer> freeTruckPool = null;
	public static ConcurrentLinkedQueue<Route> freeRoutePool = null;
	private static List<Integer> trucksOnRoad = new ArrayList<Integer>();
	

	public static void initialize(String routeDirectoryLocation) {
		drivers = new HashMap<Integer, Driver>();
		trucksOnRoad = new ArrayList<Integer>();
		DriverStaticList.reset();
		freeTruckPool = new ConcurrentLinkedQueue<Integer>();
		freeRoutePool = new ConcurrentLinkedQueue<Route>();
		
		parseRoutes(routeDirectoryLocation);
		
		configureInitialDrivers();
		
		//int numberOfTruckInstances = calculateOptimalNumberOfTruckInstances();
		
		//return numberOfTruckInstances;
		
	}
	
	private static void configureInitialDrivers() {
		Route route1 = getAvailableRoute();
		Route route2 = getAvailableRoute();
	
		Driver riskyDriver = DriverStaticList.getRiskyDriver();
		riskyDriver.provideRoute(route1);
		
		Driver mostRiskyDriver = DriverStaticList.getMostRiskyDriver();
		mostRiskyDriver.provideRoute(route2);
	}


	private static void parseRoutes(String routeDirectoryLocation) {
		List<Route> truckRoutes = new TruckRoutesParser()
				.parseAllRoutes(routeDirectoryLocation);
		LOGGER.info(truckRoutes.size() + " truck Routes were paresed");
		freeRoutePool.addAll(truckRoutes);
	}


	private synchronized static Route getAvailableRoute() {
		return freeRoutePool.poll();
	}
	
	private synchronized static Route getRoute(String  routeName) {
		Iterator<Route> iterator = freeRoutePool.iterator();
		while(iterator.hasNext()) {
			Route route = iterator.next();
			System.out.println(route.getRouteName());
			if(route.getRouteName().equals(routeName)) {
				return route;
			}
		}
		throw new RuntimeException("Route["+routeName + "] doesn't exist");
	}	
	
	public synchronized static int getNextTruckId() {
		int nextTruckId = DataGeneratorUtils.getRandomIntBetween(TRUCK_ID_START, TRUCK_ID_START + TRUCK_FLEET_SIZE, trucksOnRoad);
		trucksOnRoad.add(nextTruckId);
		return nextTruckId;
	}	

	public synchronized static Driver getNextDriver() {
		Driver nextDriver = DriverStaticList.next();
		
		//if driver has route, then it must be the risky drivers, so don't provide new route..
		if(nextDriver.getRoute() == null) {
			Route route = getAvailableRoute();
			nextDriver.provideRoute(route);				
		}
		
		drivers.put(nextDriver.getDriverId(), nextDriver);
		LOGGER.debug("Next Driver: " + nextDriver.toString());
		return nextDriver;
	}

	private static int calculateOptimalNumberOfTruckInstances() {
		int value = (int) (freeRoutePool.size() * .99);
		LOGGER.info("For " + freeRoutePool.size() + ", the optimal Number of Truck Instances  are: " + value );
		return value;
		
	}

	public static Driver getDriverAndRoute(int driverId, int routeId, String routeName) {
		Driver driver =  DriverStaticList.getDriver(driverId);
		
		//This hack was added on 1/18/19 for minifi agent automatic script workaroudn.
		String correctRouteName = replaceRouteName(routeName);
		
		//if driver has route, then it must be the risky drivers, so don't provide new route..
		if(driver.getRoute() == null) {
			Route route = getRoute(correctRouteName);
			if(route.getRouteId() == -1) {
				((RouteProvided)route).setRouteId(routeId);
			}
			driver.provideRoute(route);				
		}
		
		drivers.put(driver.getDriverId(), driver);
		LOGGER.debug("Next Driver: " + driver.toString());
		return driver;		
	}

	private static String replaceRouteName(String route) {
		if(route.contains("__")) {
			return route.replace("__", " ");
		} else {
			return route;
		}
	}		

}