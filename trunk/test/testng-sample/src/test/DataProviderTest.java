package test;

import static org.testng.Assert.assertEquals;

import org.testng.annotations.DataProvider;
import org.testng.annotations.Test;

import target.Target;

public class DataProviderTest {

	@DataProvider(name="add")
	public Object[][] data() {
		return new Object[][] {{1,2,3},{3,3,6},{6,4,10}};
	}

	@Test(dataProvider="add")
	public void verifyAdd(int a, int b, int expected) {
		System.out.println("<<< a=" + a + ", b=" + b + ", expected=" + expected);
		Target target = new Target();
		int actual = target.add(a, b);
		assertEquals(actual, expected);
	}
}
