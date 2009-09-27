package org.darin.service.user;

import org.darin.model.user.User;

public interface UserService {
	public User login(String userId, String password);
}
