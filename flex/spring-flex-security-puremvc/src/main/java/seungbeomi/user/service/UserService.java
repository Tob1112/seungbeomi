package seungbeomi.user.service;

import java.util.Collection;

import seungbeomi.user.model.User;

public interface UserService {

	//login
	public User login(String userId, String password);

	public User findUserByUserIdAndPassword(String userId, String password);

	public Collection<User> getUsers();

	public User findUserByUserId(String userId);

	//public void createSession(String userId);
	//public String getSession(String userId);

	public void removeSession();
}
