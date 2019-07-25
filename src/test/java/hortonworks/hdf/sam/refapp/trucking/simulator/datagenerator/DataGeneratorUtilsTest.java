package hortonworks.hdf.sam.refapp.trucking.simulator.datagenerator;

import hortonworks.hdf.sam.refapp.trucking.simulator.datagenerator.DataGeneratorUtils;

import java.sql.Date;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import org.junit.Test;

public class DataGeneratorUtilsTest {

	@Test
	public void testGetRandomIntBetween() {
		
		List<Integer> valueList = new ArrayList<Integer>();
		
		
		while (valueList.size() <= 90) {
			int value = DataGeneratorUtils.getRandomIntBetween(10, 100, valueList);
			valueList.add(value);
		}
		Collections.sort(valueList);
		for (Integer val: valueList) {
			System.out.println(val);
		}
	}
	
	@Test
	public void roundUp() {
		double  value = 90.52345;
		System.out.println(Math.round(value));
	}
	
	@Test
	public void dateTest() {
		
		long dateLong = 1564034944422L;
		Timestamp timestamp = new Timestamp(dateLong);
		System.out.println(timestamp);
	}
	
	@Test
	public void replaceRouteName() {
		String route = "Joplin to Kansas City";
		System.out.println(replaceRouteName(route));
	}
	
	public String replaceRouteName(String route) {
		if(route.contains("__")) {
			return route.replace("__", " ");
		} else {
			return route;
		}
	}
}
