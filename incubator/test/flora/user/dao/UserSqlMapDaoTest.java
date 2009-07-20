package flora.user.dao;

import static org.junit.Assert.*;

import java.io.IOException;
import java.io.Reader;
import java.sql.SQLException;
import java.util.List;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import com.ibatis.common.resources.Resources;
import com.ibatis.sqlmap.client.SqlMapClient;
import com.ibatis.sqlmap.client.SqlMapClientBuilder;

import flora.TestBase;
import flora.user.model.User;

public class UserSqlMapDaoTest extends TestBase{

	static Reader reader;
	static SqlMapClient sqlMap;

	private UserSqlMapDaoTest testDao;


	@Before
	public void setUp() throws IOException, SQLException{
		//backup();
		reader = Resources.getResourceAsReader("sql-map-config.xml");
		sqlMap = SqlMapClientBuilder.buildSqlMapClient(reader);
		testDao = new UserSqlMapDaoTest();
	}

	@After
	public void tearDown() throws SQLException{
		//recovery();
	}

	@Test
	public void testIsUserSqlMapDaoTest(){
		assertNotNull(testDao);
	}

	@Test
	public void testGetUserList() throws Exception{
		//cleanInsertFlatXmlData("test/flora/user/dao/testData.xml");
		List<User> list = (List<User>) sqlMap.queryForList("getUserList");
		assertEquals(2, list.size());
	}

	@Test
	public void testLogin() throws Exception{
		User testUser = new User();
		testUser.setUserId(getUser().getUserId());
		testUser.setPassword(getUser().getPassword());

		User user = (User)sqlMap.queryForObject("getUserByUserIdAndPassword",testUser);
		assertEquals("testName", user.getName());
	}

	@Test
	public void testInsertUser() throws Exception{
		//cleanInsertFlatXmlData("test/flora/user/dao/testData.xml");

		List<User> beforeUserList = (List<User>) sqlMap.queryForList("getUserList");
		assertEquals(2, beforeUserList.size());
		sqlMap.insert("insertUser", getUser());
		List<User> afterUserList = (List<User>) sqlMap.queryForList("getUserList");
		assertEquals(3, beforeUserList.size());
	}

	@Test
	public void testGetUserByUserId() throws SQLException{
		String expectedUserId = "1111";
		User user = (User) sqlMap.queryForObject("getUserByUserId",expectedUserId);
		assertEquals(expectedUserId, user.getUserId());
	}

	private User getUser() {
		User user = new User();
		user.setUserId("testUserId");
		user.setPassword("testPassword");
		user.setName("testName");
		user.setEmail("testEmail");
		return user;
	}

}
