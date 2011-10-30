package auction.dao.hibernate;

import java.util.Collection;

import org.hibernate.criterion.Expression;

import auction.dao.CategoryDAO;
import auction.model.Category;

/**
 * Hibernate-specific implementation of the <tt>CategoryDAO</tt> non-CRUD data
 * access object.
 * 
 * @author Christian Bauer
 */
public class CategoryDAOHibernate extends GenericHibernateDAO<Category, Long>
		implements CategoryDAO {

	public Collection<Category> findAll(boolean onlyRootCategories) {
		if (onlyRootCategories)
			return findByCriteria(Expression.isNull("parent"));
		else
			return findAll();
	}
}
