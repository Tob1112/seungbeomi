package suite.dao.ibatis.impl;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import suite.dao.ibatis.SuiteDao;
import suite.vo.User;

public class SuiteDaoImpl extends SqlMapClientDaoSupport implements SuiteDao{

	public User login(String userId, String password) {

		User user = new User();
		user.setUserId(userId);
		user.setPassword(password);

		return (User) getSqlMapClientTemplate().queryForObject("login", user);
	}

}
