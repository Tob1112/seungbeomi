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
import tsb.plus.designpattern.proxy.PlusConnection;
import tsb.plus.designpattern.proxy.PlusConnectionProxy;

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
		
		PlusDelegate plusDelegate = new PlusDelegateImpl();
		PlusConnection plusConnection = new PlusConnectionProxy(plusDelegate);	// Dependency Injection
		Result result = plusConnection.send(param);
		
		assertResult(result);
	}
	
	/**
	 * 델리게이트패턴
	 */
	@Test
	public void testDelegatePattern() {
		
		PlusDelegate delegate = new PlusDelegateImpl();
		Result result = delegate.send(param);
		
		assertResult(result);
	}
	
	/**
	 * 팩토리패턴
	 */
	public void testFactoryPattern() {
		
		PlusFactory factory = new PlusServiceFactory();
		PlusServiceInvoker serviceInvoker = factory.getServiceInvoker("spring"); // spring or ejb
		Result result = serviceInvoker.invoke(param);
		
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
