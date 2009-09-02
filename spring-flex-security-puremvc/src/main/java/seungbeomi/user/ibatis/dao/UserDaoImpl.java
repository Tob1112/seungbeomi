package seungbeomi.user.ibatis.dao;

import java.util.Collection;

import org.springframework.dao.DataAccessException;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import seungbeomi.user.model.User;

@Repository
@Transactional(readOnly = true)
public class UserDaoImpl extends SqlMapClientDaoSupport implements UserDao{

	public User findUserByUserId(String userId) {
		return (User) getSqlMapClientTemplate().queryForObject("findUserByUserId", userId);
	}

	@SuppressWarnings("unchecked")
	public Collection<User> findUsers() throws DataAccessException {
		return getSqlMapClientTemplate().queryForList("findUsers", null);
	}

	@SuppressWarnings("unchecked")
	public Collection<User> findUsersByName(String name) throws DataAccessException {
		return getSqlMapClientTemplate().queryForList("findUsersByName", name);
	}

	@Transactional(readOnly = false, propagation = Propagation.REQUIRES_NEW)
	public void create(User user) {
		getSqlMapClientTemplate().insert("createUser", user);
	}

	@Transactional(readOnly = false, propagation = Propagation.REQUIRES_NEW)
	public void update(User user) {
		getSqlMapClientTemplate().update("updateUser", user);
	}

	//@Transactional(readOnly = false, propagation = Propagation.REQUIRES_NEW)
	public void delete(String userId) {
		getSqlMapClientTemplate().delete("deleteUser", userId);
	}

	public User findUserByUserIdAndPassword(String userId, String password){
		User user = new User();
		user.setUserId(userId);
		user.setPassword(password);

		return (User) getSqlMapClientTemplate().queryForObject("findByUserIdAndPassword", user);
	}

}
