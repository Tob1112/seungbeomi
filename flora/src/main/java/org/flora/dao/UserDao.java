package org.flora.dao;

import java.util.List;

import org.flora.dao.ibatis.model.User;
import org.springframework.security.userdetails.UserDetails;
import org.springframework.security.userdetails.UsernameNotFoundException;

public interface UserDao extends Dao{

	public List<User> getUsers(User user);

	public User getUser(String userId);

	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException;

	public void saveUser(User user);

	public void removeUser(String userId);

}
