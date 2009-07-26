package flora.user.service;

import java.util.List;

import flora.user.model.User;

public interface UserService {

	public User login(String userId, String password);

	public void insertUser(User user);

	public int getNextId(String key);

	// for MultiActionController Method
	public User getUserByUserId(String userId);

	public List<User> getUserList();
}
