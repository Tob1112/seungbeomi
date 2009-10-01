package seungbeomi.user;

import static org.junit.Assert.*;
import static org.easymock.EasyMock.*;

import java.util.ArrayList;
import java.util.Collection;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import seungbeomi.user.UserServiceImpl;
import seungbeomi.user.UserDao;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:testContext.xml"})
public class UserServiceImplTest {

	private UserServiceImpl service;

	@Autowired
	private UserDao mockDao;

	@Before
	public void setUp(){
		service = new UserServiceImpl();
		mockDao = createMock(UserDao.class);
		service.setUserDao(mockDao);
	}

	@Test
	public void testGetUsers() {
		assertNotNull(service);
		assertNotNull(mockDao);

		String adminUserId = "adminid";
		String sonUserId = "sonid";

		expect(mockDao.getUsers()).andReturn(userCollection());
		replay(mockDao);
		Collection<User> userCollection = mockDao.getUsers();
		assertNotNull(userCollection);
		assertEquals(2, userCollection.size());
		verify(mockDao);

		for(User user : userCollection){
			if(adminUserId.equals(user.getUserId())){
				String password = "adminpw";
				assertEquals(password, user.getPassword());
			}
			if(sonUserId.equals(user.getPassword())){
				String password = "sonpw";
				assertEquals(password, "sonpw");
			}
		}
	}

	private Collection<User> userCollection(){
		Collection<User> col = new ArrayList<User>();
		User admin = new User("adminid","adminpw");
		User son = new User("sonid","sonpw");
		col.add(admin);
		col.add(son);
		return col;
	}
}
