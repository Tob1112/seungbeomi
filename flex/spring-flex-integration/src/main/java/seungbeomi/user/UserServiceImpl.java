package seungbeomi.user;

import java.util.Collection;

public class UserServiceImpl implements UserService{

	private UserDao userDao;

	public void setUserDao(UserDao userDao) {
		this.userDao = userDao;
	}

	public Collection<User> getUsers() {
		return userDao.getUsers();
	}
}