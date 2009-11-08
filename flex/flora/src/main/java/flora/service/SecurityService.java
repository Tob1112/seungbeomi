package flora.service;

import flora.model.User;

public interface SecurityService {

	//public User authenticateUser(User user);
	public User authenticateUser(String userId, String password);

	public void test();

}
