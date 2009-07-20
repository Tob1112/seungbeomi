package flora.user.dao;

import java.util.List;

import flora.user.model.User;


/**
 * Persistence layer
 * */
public interface UserDao {

	public List<User> getUserList();

	public User login(String userId, String password);

	public void insertUser(User user);

	// for MultiActionController
	public User getUserByUserId(String userId);


}
