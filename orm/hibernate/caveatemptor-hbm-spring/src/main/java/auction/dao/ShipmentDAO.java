package auction.dao;

import auction.model.Shipment;

/**
 * Business DAO operations related to the <tt>Shipment</tt> entity.
 * <p>
 * This is an empty interface, currently there are no business-oriented data
 * access operations for this class. However, preparing the interface means
 * preparing ourself for future changes. That way, no refactoring is necessary
 * should we add methods one day. Note that with a sensible factory, such as the
 * <tt>HibernateDAOFactory</tt>, no concrete implementation of this empty
 * interface is needed, but a parameterized <tt>GenericDAO</tt> for Hibernate
 * can be constructed and used.
 * 
 * @see auction.model.Comment
 * @author Christian Bauer
 */
public interface ShipmentDAO extends GenericDAO<Shipment, Long> {
	// Empty
}
