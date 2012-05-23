package tsb.plus.designpattern;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertThat;

import org.junit.Before;
import org.junit.Ignore;
import org.junit.Test;

import tsb.plus.designpattern.delegate.PlusDelegate;
import tsb.plus.designpattern.delegate.PlusDelegateImpl;
import tsb.plus.designpattern.model.Param;
import tsb.plus.designpattern.model.Result;
import tsb.plus.designpattern.proxy.PlusConnection;
import tsb.plus.designpattern.proxy.PlusConnectionProxy;

public class DesignPatternRuncher {
	
	private Param param;
	
	@Before
	public void beforeClass() {
		param = new Param();
		param.setName("seungbeomi");
		
	}
	
	@Test
	public void testProxyPattern() {
		
		PlusDelegate plusDelegate = new PlusDelegateImpl();
		PlusConnection plusConnection = new PlusConnectionProxy(plusDelegate);	// Dependency Injection
		Result result = plusConnection.send(param);
		
		assertThat(result.getName(), is("seungbeomi"));
		assertThat(result.getAge(), is(34));
		assertThat(result.getCompany(), is("TSB"));
	}
	
	@Ignore @Test
	public void testDelegatePattern() {
		
		PlusDelegate delegate = new PlusDelegateImpl();
		Result result = delegate.send(param);
		
		assertThat(result.getName(), is("seungbeomi"));
		assertThat(result.getAge(), is(34));
		assertThat(result.getCompany(), is("TSB"));
	}

}
