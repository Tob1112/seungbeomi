package flora.user.dao;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import flora.ApplicationContextTestBase;
import flora.user.model.User;

public class UserSqlMapDaoTestOld extends ApplicationContextTestBase {

	private UserDao userDao;

	public void setUserDao(UserDao userDao) {
		this.userDao = userDao;
	}

	@Before
	public void setUp() throws IOException, SQLException{
		//backup();
	}

	@After
	public void tearDown() throws SQLException{
		//recovery();
	}

	@Test
	public void testIsUserDao(){
		assertNotNull(userDao);
	}

	@Test
	public void testGetUserList() throws Exception{
		//cleanInsertFlatXmlData("test/flora/user/dao/testData.xml");
		List<User> list = userDao.getUserList();
		assertEquals(2, list.size());
	}

/*	@Test
	public void testLogin(){

	}

	@Test
	public void testInsertUser(){

	}

	// for MultiActionController
	@Test
	public void testGetUserByUserId(){

	}
*/



	private User getUser(){
		User user = new User();
		user.setUserId("testId");
		user.setPassword("testPw");
		user.setName("testName");
		user.setEmail("test@seungbeomi.net");
		return user;
	}
}
