package test;

import static org.testng.Assert.*;

import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Test;

import target.Target;

public class TargetTest {

	private Target target;

	public TargetTest() {
		System.out.println("<<< Constructor");
	}

	@BeforeMethod
	public void init() {
		System.out.println("<<< call init()");
		target = new Target();
	}

	@Test
	public void verifyAdd1() {
		System.out.println("<<< call verifyAdd1");
		int result = target.add(1, 2);
		assertEquals(result, 3);
	}

	@Test
	public void verifyAdd2() {
		System.out.println("<<< call verifyAdd2");
		int result = target.add(3, 3);
		assertEquals(result, 6);
	}

	@Test(expectedExceptions = {java.lang.RuntimeException.class})
	public void exceptionTest() {
		System.out.println("<<< call exceptionTest()");
		target.throwException();
	}

}
