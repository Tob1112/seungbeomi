package auction.dao.hibernate;

import java.util.List;

import auction.dao.BillingDetailsDAO;
import auction.model.BillingDetails;

/**
 * Hibernate-specific implementation of the <tt>BillingDetailsDAO</tt> non-CRUD
 * data access object.
 * 
 * @author Christian Bauer
 */
public class BillingDetailsDAOHibernate extends
		GenericHibernateDAO<BillingDetails, Long> implements BillingDetailsDAO {

	@SuppressWarnings("unchecked")
	public List<BillingDetails> findConcrete(Class concreteClass) {
		return getSession().createCriteria(concreteClass).list();
	}
}
