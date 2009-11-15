package seungbeomi.user.ibatis.dao;

import java.util.Collection;

import org.springframework.dao.DataAccessException;

import seungbeomi.user.model.User;

/**
 * User DAO interface.
 *
 * @author son seung-beom
 */
public interface UserDao {

	/**
	 * Find user by userid
	 */
	public User findUserByUserId(String userId);

	/**
	 * Find users
	 */
	public Collection<User> findUsers() throws DataAccessException ;

	/**
	 * Find users by name
	 */
	public Collection<User> findUsersByName(String name) throws DataAccessException;

	/**
	 * Create user
	 * */
	public void create(User user);

	/**
	 * Save user
	 */
	public void update(User user) ;

	/**
	 * Delete user
	 */
	public void delete(String userId);

	/**
	 * Login
	 */
	public User findUserByUserIdAndPassword(String userId, String password);

	/**
	 * getCount for WatchService
	 */
	public Integer getCount();
}
