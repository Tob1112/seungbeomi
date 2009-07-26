package flora.user.service;

import java.util.List;

import flora.user.dao.SequenceDao;
import flora.user.dao.UserDao;
import flora.user.model.User;

public class UserServiceImpl implements UserService {

	private UserDao userDao;
	private SequenceDao sequenceDao;

	// -------------------------------------------------------------------------
	// Setter methods for dependency injection
	// -------------------------------------------------------------------------
	public void setUserDao(UserDao userDao) {
		this.userDao = userDao;
	}

	public void setSequenceDao(SequenceDao sequenceDao) {
		this.sequenceDao = sequenceDao;
	}

	// -------------------------------------------------------------------------
	// Operation methods, implementing the UserFacade interface
	// -------------------------------------------------------------------------
	public User login(String userId, String password) {
		return this.userDao.login(userId, password);
	}

	public void insertUser(User User) {
		// insert sequence
		// User.setId(getNextId("User.seq"));
		this.userDao.insertUser(User);
	}

	// get sequence
	public int getNextId(String key) {
		return sequenceDao.getNextId(key);
	}

	// for MultiActionController
	public User getUserByUserId(String UserId){
		return userDao.getUserByUserId(UserId);
	}

	//@Override
	public List<User> getUserList() {
		return userDao.getUserList();
	}

}
