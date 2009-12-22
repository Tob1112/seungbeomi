package org.flora.service;

import java.util.List;

import org.flora.dao.UserDao;
import org.flora.dao.ibatis.model.User;
import org.flora.exception.UserExistsException;
import org.springframework.security.userdetails.UsernameNotFoundException;

public interface UserManager extends GenericManager<User, String>{

    public void setUserDao(UserDao userDao);

    public User getUser(String userId);

    public User getUserByUsername(String username) throws UsernameNotFoundException;

    public List<User> getUsers(User user);

    public void saveUser(User user) throws UserExistsException;

    public void removeUser(String userId);

}
