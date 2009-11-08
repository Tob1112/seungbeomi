package flora.dao;

import java.util.List;

import org.springframework.security.userdetails.UsernameNotFoundException;

import flora.model.User;

public interface UserDao extends GenericDao<User, String>{

	User loadUserByUsername(String username) throws UsernameNotFoundException;

	List<User> getUsers();

	User saveUser(User user);
}
