package org.darin.service.user.impl;

import org.darin.model.user.User;
import org.darin.persist.user.UserDao;
import org.darin.service.user.UserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


public class UserServiceImpl implements UserService{

	private Logger logger = LoggerFactory.getLogger(getClass());

	private UserDao userDao;

	public User login(String userId, String password) {

		return null;
	}

}
