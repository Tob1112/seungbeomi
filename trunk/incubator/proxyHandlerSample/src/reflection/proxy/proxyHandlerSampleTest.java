package reflection.proxy;

import static org.junit.Assert.*;

import org.junit.Test;

public class proxyHandlerSampleTest {

	private static final String EXPECTED_ID = "seungbeomi";

	@Test
	public void testProxyHandler() {

		User user;
		UserRepository repository;

		user= new DefaultUser();
		repository = new UserRepository();

		user = repository.findUser("son");

		assertEquals(EXPECTED_ID, user.getName());
	}
}
