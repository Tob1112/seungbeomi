package org.flora.dao.ibatis;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.flora.dao.UserDao;
import org.flora.dao.ibatis.model.Role;
import org.flora.dao.ibatis.model.User;
import org.springframework.orm.ObjectRetrievalFailureException;
import org.springframework.security.userdetails.UserDetails;
import org.springframework.security.userdetails.UserDetailsService;
import org.springframework.security.userdetails.UsernameNotFoundException;

public class UserDaoiBatis extends GenericDaoiBatis<User, String> implements UserDao, UserDetailsService {

	/**
	 * User list 를 구하고 user 의 권한을 setting
	 *
	 * @see org.flora.dao.UserDao#getUsers(org.flora.dao.ibatis.model.User)
	 */
	@Override
	public List<User> getUsers(User user) {
		List<User> users = getAll(user);
		// List<User> users = getSqlMapClientTemplate().queryForList("getUsers");

		for (int i = 0; i < users.size(); i++) {
			user = (User) users.get(i); // user list 로부터 user를 하나씩 꺼낸다.

			List roles = getRoles(user);
			user.setRoles(new HashSet(roles));
			users.set(i, user);
		}
		return users;
	}

	@Override
	public User getUser(String id) {
		User user = (User) get(new User(), id);

		if (user == null) {
			log.warn("user not found!!");
			throw new ObjectRetrievalFailureException(User.class, user);
		} else {
			List roles = getRoles(user);
			user.setRoles(new HashSet(roles));
		}
		return user;
	}

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		User user = (User) getSqlMapClientTemplate().queryForObject("getUserByUsername", username);

		if (user == null) {
			log.warn("user not found!!");
			throw new UsernameNotFoundException("user '" + username + "' not found...");
		} else {
			List roles = getRoles(user);
			user.setRoles(new HashSet(roles));
		}
		//TODO
		// user 를 반환하는데 spring security의 UserDetails 가 어떤식으로 값을 가지는 거지???
		return user;
	}

	@Override
	public void saveUser(User user) {
		prepareObjectForSaveOrUpdate(user);

		if (user.getId() == null) {	// 신규유저
			String userId = (String) getSqlMapClientTemplate().insert("addUser", user);
			user.setId(user.getId());
			addUserRoles(user);
		} else {	//기존유저
			getSqlMapClientTemplate().update("updateUser", user);
			deleteUserRoles(user.getId());
			addUserRoles(user);
		}
	}

	@Override
	public void removeUser(String id) {
		deleteUserRoles(id);
		getSqlMapClientTemplate().update("deleteUserRoles", id);
	}

	// ------------------------------------------------

	/**
	 * 권한 추가 메소드
	 * @param user
	 */
	private void addUserRoles(User user) {
		if (user.getRoles() != null) {	// 유저의 권한이 존재한다.
			for (Iterator iter = user.getRoles().iterator(); iter.hasNext();) {
				Role role = (Role) iter.next();
				Map newRole = new HashMap();
				newRole.put("userId", user.getId());
				newRole.put("roleId", role.getId());

				List userRoles = getRoles(user);

				if (userRoles.isEmpty()) {
					getSqlMapClientTemplate().insert("addUserRole", newRole);
				}
			}
		}

	}

	/**
	 * 권한 삭제 메소드
	 *
	 * @param userId
	 */
	private void deleteUserRoles(String id) {
		getSqlMapClientTemplate().update("deleteUserRoles", id);

	}
}
