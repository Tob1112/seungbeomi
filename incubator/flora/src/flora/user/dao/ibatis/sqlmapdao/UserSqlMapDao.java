package flora.user.dao.ibatis.sqlmapdao;

import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;
import org.springframework.util.Assert;

import flora.user.dao.UserDao;
import flora.user.model.User;


public class UserSqlMapDao extends SqlMapClientDaoSupport implements UserDao{

	static Logger log = Logger.getLogger(UserSqlMapDao.class);

	//@Override
	public User getUserByUserId(String userId) {
		Assert.notNull(userId, "userId is not null");
		return (User) getSqlMapClientTemplate().queryForObject("getUserByUserId", userId);
	}

	//@Override
	public List<User> getUserList() {
		return (List<User>) getSqlMapClientTemplate().queryForList("getUserList");
	}

	//@Override
	public void insertUser(User user) {
		Assert.notNull(user, "user is not null");

		getSqlMapClientTemplate().insert("insertUser",user);
	}

	//@Override
	public User login(String userId, String password) {
		Assert.notNull(userId, "userId is not null");
		Assert.notNull(password, "password is not null");

		User user = new User();
		user.setUserId(userId);
		user.setPassword(password);
		return (User)getSqlMapClientTemplate().queryForObject("getUserByUserIdAndPassword", user);
	}
}
