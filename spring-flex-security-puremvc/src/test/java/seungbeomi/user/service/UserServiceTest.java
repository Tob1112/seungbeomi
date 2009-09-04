package seungbeomi.user.service;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import static org.easymock.EasyMock.*;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import seungbeomi.user.ibatis.dao.UserDao;
import seungbeomi.user.model.User;
import seungbeomi.user.service.UserServiceImpl;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration
public class UserServiceTest {

	private UserServiceImpl service;

	@Autowired
	private UserDao mockUserDao;

	@Before
	public void setUp() {
		service = new UserServiceImpl();
		mockUserDao = createMock(UserDao.class);
		service.setUserDao(mockUserDao);
	}

	@Test
	public void testLogin() {
		assertNotNull("userService is not null", service);

		String adminUserId = "admin";
		String adminPassword = "admin";

		User adminUser = service.login(adminUserId, adminPassword);
		//assertEquals("ROLE_ADMIN", adminUser.getAuthority());

		String userUserId = "admin";
		String userPassword = "admin";

		User userUser = service.login(userUserId, userPassword);
		//assertEquals("ROLE_ADMIN", userUser.getAuthority());


	}

	@Test
	public void testFindUserByUserIdAndPassword() {
		assertNotNull("userService is not null", service);
		assertNotNull("userDao is not null", mockUserDao);

		User user = new User();
		user.setUserId("son");
		user.setPassword("son");
		user.setName("seungbeomi");
		user.setEmail("son@seungbeomi.net");

		expect(mockUserDao.findUserByUserIdAndPassword("son", "son")).andReturn(user);
		replay(mockUserDao);
		User acturalUser = mockUserDao.findUserByUserIdAndPassword("son", "son");
		assertEquals("seungbeomi", acturalUser.getName());
		assertEquals("son@seungbeomi.net", acturalUser.getEmail());
		verify(mockUserDao);
	}

	@Test
	public void testGetUsers() {
		assertNotNull("userService is not null", service);
		assertNotNull("userDao is not null", mockUserDao);

		String adminUserId = "admin";
		String sonUserId = "son";

		expect(mockUserDao.getUsers()).andReturn(getUserCollection());
		replay(mockUserDao);
		Collection<User> userCollection= mockUserDao.getUsers();
		assertNotNull("userCollection is not null.",userCollection);
		verify(mockUserDao);

		for(User user : userCollection) {
			if(adminUserId.equals(user.getUserId())) {
				String password = "admin";
				String name = "administrator";
				String email = "admin@seungbeomi.net";

				assertEquals(password, user.getPassword());
				assertEquals(name, user.getName());
				assertEquals(email, user.getEmail());
			}
			if(sonUserId.equals(user.getUserId())) {
				String password = "son";
				String name = "seungbeomi";
				String email = "son@seungbeomi.net";

				assertEquals(password, user.getPassword());
				assertEquals(name, user.getName());
				assertEquals(email, user.getEmail());
			}
		}
	}

	private Collection<User> getUserCollection(){
		List<User> list = new ArrayList<User>();
		User admin = new User();
		User son = new User();

		admin.setUserId("admin");
		admin.setPassword("admin");
		admin.setName("administrator");
		admin.setEmail("admin@seungbeomi.net");

		son.setUserId("son");
		son.setPassword("son");
		son.setName("seungbeomi");
		son.setEmail("son@seungbeomi.net");

		list.add(admin);
		list.add(son);

		return list;
	}
}
