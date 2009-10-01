package seungbeomi.user;

import static org.junit.Assert.*;

import java.sql.SQLException;
import java.util.Collection;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:testContext.xml"})
public class UserDaoImplTest extends DatabaseTestBase{

	@Autowired
	private UserDao userDao;

	@Before
	public void setUp() throws SQLException{
		backup("sampledb");
	}

	@After
	public void tearDown() throws SQLException{
		recovery();
	}

	@Test
	public void testGetUsers() throws Exception {
		assertNotNull(userDao);

		Collection<User> col = userDao.getUsers();
		assertEquals(2, col.size());

		cleanInsertFlatXmlData("src/test/resource/testData.xml");
		col = userDao.getUsers();
		assertEquals(1, col.size());

	}
}
