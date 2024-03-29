package auction.dao;

import auction.model.AddressEntity;
import auction.model.User;

/**
 * Business DAO operations related to the <tt>User</tt> entity.
 * 
 * @see User
 * @author Christian Bauer
 */
public interface UserDAO extends GenericDAO<User, Long> {

	public User validateLogin(User user);

	// Could be in a separate interface...
	public void persistAddress(AddressEntity address);
}
