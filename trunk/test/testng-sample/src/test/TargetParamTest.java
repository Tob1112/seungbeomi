package test;

import static org.testng.Assert.*;

import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Parameters;
import org.testng.annotations.Test;

import target.Target;

public class TargetParamTest {

	private Target target;

	public TargetParamTest() {
		System.out.println("<<< Constructor");
	}

	@BeforeMethod
	public void init() {
		System.out.println("<<< call init()");
		target = new Target();
	}

	@Test(enabled=false)
	@Parameters(value = {"paramA","paramB"})
	public void verifyAdd1(int a, int b) {
		int result = target.add(a, b);
		System.out.println("<<< " + a + " + " + b + " = " + result);
		assertEquals(result, 3);
	}

}
