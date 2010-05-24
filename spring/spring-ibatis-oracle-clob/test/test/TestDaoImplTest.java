package test;

import static org.junit.Assert.*;

import java.sql.SQLException;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "test-applicationContext.xml" })
public class TestDaoImplTest extends DBTestBase{

	private static final String BACKUP_TABLE_NAME = "test";
	
	@Autowired
	public TestDao testDao;
	
	
	@Before
	public void before() throws SQLException {
		backup(BACKUP_TABLE_NAME);
	}
	
	@After
	public void after() throws SQLException {
		recovery();
	}
	
	@Test
	public void testSelect() {
		assertNotNull(testDao);
		
		int id = 1;
		String expected = "userId1";
		
		
		User user = testDao.select(id);
		assertEquals(expected, user.getUserId());
	}
	
}
