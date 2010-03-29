package seungbeomi.user.ibatis.dao;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertNull;

import java.util.Collection;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import seungbeomi.user.model.User;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration
public class UserDaoTest {

	private Logger logger = LoggerFactory.getLogger(getClass());

	@Autowired
	protected UserDao userDao = null;

	@Test
	public void testFindUserByUserId() {
		assertNotNull("User DAO is null.", userDao);

		String userId = "son";
		String password = "son";
		String name = "seungbeomi";
		String email = "son@seungbeomi.net";

		User user = userDao.findUserByUserId(userId);

		assertNotNull("User is null.", user);

		assertEquals(userId, user.getUserId());
		assertEquals(password, user.getPassword());
		assertEquals(name, user.getName());
		assertEquals(email, user.getEmail());

	}

	@Test
	public void testGetUsers() {
		assertNotNull("User DAO is null.", userDao);

		Collection<User> userList = userDao.getUsers();

		int expected = 2;

		assertEquals(expected, userList.size());

		String firstUserId = "admin";
		String secondUserId = "son";

		for (User user : userList) {
			assertNotNull("User is null.", user);

			if(firstUserId.equals(user.getUserId())) {
				String firstPassword = "admin";
				String firstName = "administrator";
				String firstEmail = "admin@seungbeomi.net";

				assertEquals(firstPassword, user.getPassword());
				assertEquals(firstName, user.getName());
				assertEquals(firstEmail, user.getEmail());

			}

			if(secondUserId.equals(user.getUserId())) {
				String secondPassword = "son";
				String secondName = "seungbeomi";
				String secondEmail = "son@seungbeomi.net";

				assertEquals(secondPassword, user.getPassword());
				assertEquals(secondName, user.getName());
				assertEquals(secondEmail, user.getEmail());

			}
			logger.debug(user.toString());
		}
	}

	@Test
	public void testFindUsersByName() {
		assertNotNull("User DAO is null.", userDao);

		final String NAME = "seungbeomi";

		Collection<User> userList = userDao.findUsersByName(NAME);

		assertNotNull("userList is null.", userList);

		int expected = 1;

		assertEquals(expected, userList.size());

	}

	@Test
	public void testCreate() {
		assertNotNull("User DAO is null.", userDao);

		User testUser = new User();
		testUser.setUserId("testUserId");
		testUser.setPassword("testPassword");
		testUser.setName("testName");
		testUser.setEmail("testEmail");

		userDao.create(testUser);

		User actualUser = userDao.findUserByUserId(testUser.getUserId());

		assertNotNull("User is null.", actualUser);

		assertEquals(testUser.getUserId(), actualUser.getUserId());
		assertEquals(testUser.getPassword(), actualUser.getPassword());
		assertEquals(testUser.getName(), actualUser.getName());
		assertEquals(testUser.getEmail(), actualUser.getEmail());
	}

	@Test
	public void testUpdate() {
		assertNotNull("User DAO is null.", userDao);

		String USERID = "testUserId";
		String CHANGE_NAME = "spring";

		User user = userDao.findUserByUserId(USERID);

		assertNotNull("User is null.", user);

		user.setName(CHANGE_NAME);

		userDao.update(user);

		User changeduser = userDao.findUserByUserId(USERID);

		assertEquals(CHANGE_NAME, changeduser.getName());
	}

	@Test
	public void testDelete() {
		assertNotNull("User DAO is null.", userDao);

		String USERID = "testUserId";

		userDao.delete(USERID);

		User user = userDao.findUserByUserId(USERID);

		assertNull("User is not null", user);
	}

	@Test
	public void testFindUserByUserIdAndPassword(){
		assertNotNull("User DAO is null.", userDao);

		String userId = "son";
		String password= "son";
		String name = "seungbeomi";
		String email = "son@seungbeomi.net";

		User user = userDao.findUserByUserIdAndPassword(userId, password);

		assertNotNull("User is not null.", user);
		assertEquals(userId, user.getUserId());
		assertEquals(password, user.getPassword());
		assertEquals(name, user.getName());
		assertEquals(email, user.getEmail());
	}
}
