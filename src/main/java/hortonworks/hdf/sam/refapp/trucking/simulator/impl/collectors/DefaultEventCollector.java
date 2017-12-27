package hortonworks.hdf.sam.refapp.trucking.simulator.impl.collectors;

import hortonworks.hdf.sam.refapp.trucking.simulator.impl.domain.AbstractEventCollector;


public class DefaultEventCollector extends AbstractEventCollector {

	
	@Override
	public void onReceive(Object message) throws Exception {
		logger.info("on receive", message);
	}


}
