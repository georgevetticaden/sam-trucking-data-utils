package hortonworks.hdf.sam.refapp.trucking.simulator.impl.collectors.kinesis;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.junit.Test;

import com.amazonaws.services.kinesis.AmazonKinesis;

public class KinesisTest extends BaseKinesisTest {
	
	protected Log LOG = LogFactory.getLog(KinesisTest.class);

	@Test
	public void testKinesisConnection() {
		//LOG.info("About to test Kinesis connection");
		AmazonKinesis kinesisClinet = createKinesisClient();
	}
	
	
	
	
	
}
