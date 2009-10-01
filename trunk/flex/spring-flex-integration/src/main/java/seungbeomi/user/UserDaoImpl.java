package seungbeomi.user;

import java.util.Collection;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

public class UserDaoImpl extends SqlMapClientDaoSupport implements UserDao{

	public Collection<User> getUsers() {
		return getSqlMapClientTemplate().queryForList("getUsers");
	}
}
