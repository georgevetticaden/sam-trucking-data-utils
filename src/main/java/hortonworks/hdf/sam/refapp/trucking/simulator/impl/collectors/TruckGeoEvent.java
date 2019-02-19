package hortonworks.hdf.sam.refapp.trucking.simulator.impl.collectors;

import java.io.Serializable;

public class TruckGeoEvent implements Serializable {
	


	private static final long serialVersionUID = -2079662627167609187L;
	
	private String eventTime;
	private Long eventTimeLong;	
	private String eventSource;
	
	private Integer truckId;
	private Integer driverId;
	private String driverName;
	private Integer routeId;
	private String route;
	private String eventType;
	private Double longitude;
	private Double latitude;
	private Long correlationId;
	
	private String edgeAgentIdentifier;
	
	public String getEventTime() {
		return eventTime;
	}
	public void setEventTime(String eventTime) {
		this.eventTime = eventTime;
	}
	public String getEventSource() {
		return eventSource;
	}
	public void setEventSource(String eventSource) {
		this.eventSource = eventSource;
	}
	public Integer getTruckId() {
		return truckId;
	}
	public void setTruckId(Integer truckId) {
		this.truckId = truckId;
	}
	public Integer getDriverId() {
		return driverId;
	}
	public void setDriverId(Integer driverId) {
		this.driverId = driverId;
	}
	public String getDriverName() {
		return driverName;
	}
	public void setDriverName(String driverName) {
		this.driverName = driverName;
	}
	public Integer getRouteId() {
		return routeId;
	}
	public void setRouteId(Integer routeId) {
		this.routeId = routeId;
	}
	public String getRoute() {
		return route;
	}
	public void setRoute(String route) {
		this.route = route;
	}
	public String getEventType() {
		return eventType;
	}
	public void setEventType(String eventType) {
		this.eventType = eventType;
	}

	public Long getEventTimeLong() {
		return eventTimeLong;
	}
	public void setEventTimeLong(Long eventTimeLong) {
		this.eventTimeLong = eventTimeLong;
	}
	public Double getLongitude() {
		return longitude;
	}
	public void setLongitude(Double longitude) {
		this.longitude = longitude;
	}
	public Double getLatitude() {
		return latitude;
	}
	public void setLatitude(Double latitude) {
		this.latitude = latitude;
	}
	public Long getCorrelationId() {
		return correlationId;
	}
	public void setCorrelationId(Long correlationId) {
		this.correlationId = correlationId;
	}
	public String getEdgeAgentIdentifier() {
		return edgeAgentIdentifier;
	}
	public void setEdgeAgentIdentifier(String edgeAgentIdentifier) {
		this.edgeAgentIdentifier = edgeAgentIdentifier;
	}
	
	
	

}
