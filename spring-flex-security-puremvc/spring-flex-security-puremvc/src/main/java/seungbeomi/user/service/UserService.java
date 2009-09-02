package seungbeomi.user.service;

import java.util.Collection;

import seungbeomi.user.model.User;

public interface UserService {

	//login
	public User authenticateUser(String userId, String password);

	public User findUserByUserIdAndPassword(String userId, String password);

	public Collection<User> findUsers();

	public User findUserByUserId(String userId);

	//public void createSession(String userId);
	//public String getSession(String userId);

	public void removeSession();
}
