package com.leinbow.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.leinbow.dao.UserDao;
import com.leinbow.domain.User;
import com.leinbow.service.UserExistsException;
import com.leinbow.service.UserService;

@Service("userService")
public class UserServiceImpl extends GenericServiceImpl<User, Long> implements UserService {


    private UserDao userDao;

    @Autowired
    public void setUserDao(UserDao userDao) {
        this.userDao = userDao;
    }

    @Override
    public User getUser(String userId) {
        return userDao.get(new Long(userId));
    }

    @Override
    public User getUserByUsername(String username) throws UsernameNotFoundException {

        return null;
    }

    @Override
    public List<User> getUsers() {
        return userDao.list();
    }

    @Override
    public void removeUser(String userId) {

    }

    @Override
    public User saveUser(User user) throws UserExistsException {
        return null;
    }

}
