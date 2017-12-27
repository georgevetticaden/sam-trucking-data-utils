package hortonworks.hdf.sam.refapp.trucking.simulator.impl.collectors.kinesis;

import hortonworks.hdf.sam.refapp.trucking.simulator.impl.collectors.kinesis.KinesisEventSerializedInternalWithRegistryEnrichedTopicsCollector;
import hortonworks.hdf.sam.refapp.trucking.simulator.schemaregistry.TruckSchemaConfig;

import com.amazonaws.services.kinesis.AmazonKinesis;

public abstract class BaseKinesisTest {

	public static final String REGION_NAME = "us-west-2";

	
	protected AmazonKinesis createKinesisClient() {
		AmazonKinesis kinesisClinet = KinesisEventSerializedInternalWithRegistryEnrichedTopicsCollector.createKinesisClient(REGION_NAME);
		KinesisEventSerializedInternalWithRegistryEnrichedTopicsCollector.validateStream(kinesisClinet, TruckSchemaConfig.KAFKA_TRUCK_GEO_EVENT_TOPIC_NAME);
		KinesisEventSerializedInternalWithRegistryEnrichedTopicsCollector.validateStream(kinesisClinet, TruckSchemaConfig.KAFKA_TRUCK_SPEED_EVENT_TOPIC_NAME);
		return kinesisClinet;
	}
	

}


