package flora.dao.ibatis;

import java.util.List;

import org.springframework.security.userdetails.UsernameNotFoundException;

import com.ibatis.sqlmap.client.SqlMapClient;

import flora.dao.UserDao;
import flora.model.User;

public class UserDaoIbatis extends GenericDaoIbatis<User, String> implements UserDao{

	public UserDaoIbatis(SqlMapClient sqlMapClient) {
		super(User.class, sqlMapClient);
	}

	@Override
	public List<User> getUsers() {
		return null;
	}

	@Override
	public User loadUserByUsername(String username)
			throws UsernameNotFoundException {
		return null;
	}

	@Override
	public User saveUser(User user) {
		return null;
	}

	public boolean exists(String id) {
		return false;
	}

	public void remove(String id) {

	}

}
