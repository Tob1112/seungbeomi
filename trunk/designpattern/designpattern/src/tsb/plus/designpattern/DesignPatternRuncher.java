package tsb.plus.designpattern;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertThat;

import org.junit.Before;
import org.junit.Test;

import tsb.plus.designpattern.delegate.PlusDelegate;
import tsb.plus.designpattern.delegate.PlusDelegateImpl;
import tsb.plus.designpattern.factory.PlusFactory;
import tsb.plus.designpattern.factory.PlusServiceFactory;
import tsb.plus.designpattern.factory.PlusServiceInvoker;
import tsb.plus.designpattern.model.Param;
import tsb.plus.designpattern.model.Result;
import tsb.plus.designpattern.proxy.PlusProxy;
import tsb.plus.designpattern.proxy.PlusProxyImpl;

public class DesignPatternRuncher {
	
	private Param param;
	
	/**
	 * 테스트Param
	 */
	@Before
	public void beforeClass() {
		param = new Param();
		param.setName("seungbeomi");
		
	}
	
	/**
	 * 프록시패턴
	 */
	@Test
	public void testProxyPattern() {
		System.out.println("[PROXY PATTERN] =======================================");
		
		PlusProxy proxy = new PlusProxyImpl();
		Result result = proxy.send(param);
		
		assertResult(result);
	}
	
	/**
	 * 델리게이트패턴
	 */
	@Test
	public void testDelegatePattern() {
		System.out.println("[DELEGATE PATTERN] =======================================");
		
		PlusDelegate delegate = new PlusDelegateImpl();
		Result result = delegate.send(param);
		
		assertResult(result);
	}
	
	/**
	 * 팩토리패턴
	 */
	@Test
	public void testFactoryPattern() {
		System.out.println("[FACTORY PATTERN] =======================================");
		
		PlusFactory factory = new PlusServiceFactory();
		PlusServiceInvoker springServiceInvoker = factory.getServiceInvoker("spring");
		Result springResult = springServiceInvoker.invoke(param);
		
		assertResult(springResult);
		
		PlusServiceInvoker ejbServiceInvoker = factory.getServiceInvoker("ejb");
		Result ejbResult = ejbServiceInvoker.invoke(param);
		
		assertResult(ejbResult);
	}
	
	/**
	 * TSB Framewok
	 */
	@Test
	public void testTSBFramework() {
		System.out.println("[TSB Framework] =======================================");
		
		tsb.plus.designpattern.fw.PlusProxy proxy = new tsb.plus.designpattern.fw.PlusProxyImpl();
		Result result = proxy.send(param);
		
		assertResult(result);
		
	}
	
	/**
	 * 결과값 검증
	 * @param result
	 */
	private void assertResult(Result result) {
		assertThat(result.getName(), is("seungbeomi"));
		assertThat(result.getAge(), is(34));
		assertThat(result.getCompany(), is("TSB"));
	}
	

}
