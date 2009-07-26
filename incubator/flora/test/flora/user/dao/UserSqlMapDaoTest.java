package flora.user.dao;

import static org.junit.Assert.assertEquals;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import flora.common.dao.ApplicationContextTestBase;
import flora.user.dao.ibatis.sqlmapdao.UserSqlMapDao;
import flora.user.model.User;

public class UserSqlMapDaoTest extends ApplicationContextTestBase{
	private static UserSqlMapDao userSqlMapDao;
	private String testData = "test/flora/user/dao/testdata.xml";

	public void setUserSqlMapDao(UserSqlMapDao userSqlMapDao) {
		this.userSqlMapDao = userSqlMapDao;
	}

	@Before
	public void setUp() throws IOException, SQLException{
		backup();
	}

	@After
	public void tearDown() throws SQLException{
		recovery();
	}

	@Test
	public void testGetUserList() throws Exception{
		cleanInsertFlatXmlData(testData);
		List<User> list = userSqlMapDao.getUserList();
		assertEquals(2, list.size());
	}

	@Test
	public void testLogin() throws Exception{
		cleanInsertFlatXmlData(testData);
		User user = userSqlMapDao.login("1111", "1111");
		assertEquals("son",user.getName());
	}

	@Test
	public void testInsertUser(){
		List<User> beforeList = userSqlMapDao.getUserList();
		assertEquals(2, beforeList.size());
		userSqlMapDao.insertUser(getUser());
		List<User> afterList = userSqlMapDao.getUserList();
		assertEquals(3, afterList.size());
	}

	@Test
	public void testGetUserByUserId() throws Exception{
		cleanInsertFlatXmlData(testData);
		User user = userSqlMapDao.getUserByUserId("1111");
		assertEquals("son", user.getName());
	}

	private User getUser(){
		User user = new User();
		user.setUserId("testId");
		user.setPassword("testPw");
		user.setName("testName");
		user.setEmail("test@seungbeomi.net");
		return user;
	}
}
