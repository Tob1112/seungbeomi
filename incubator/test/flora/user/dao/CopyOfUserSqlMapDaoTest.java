package flora.user.dao;

import static org.junit.Assert.assertEquals;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import flora.TestBase;
import flora.user.dao.ibatis.sqlmapdao.UserSqlMapDao;
import flora.user.model.User;

public class CopyOfUserSqlMapDaoTest extends TestBase {

	UserSqlMapDao userSqlMapDao;

	@Before
	public void setUp() throws IOException, SQLException{
		//backup();
		userSqlMapDao = userSqlMapDao.getInstance();
	}

	@After
	public void tearDown() throws SQLException{
		//recovery();
	}

	@Test
	public void testIsUserDao(){

	}

	@Test
	public void testGetUserList() throws Exception{
		//cleanInsertFlatXmlData("test/flora/user/dao/testData.xml");
		List<User> list = userSqlMapDao.getUserList();
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
