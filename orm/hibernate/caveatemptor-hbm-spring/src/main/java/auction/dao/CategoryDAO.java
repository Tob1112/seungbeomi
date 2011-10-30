package auction.dao;

import java.util.Collection;

import auction.model.Category;

/**
 * Business DAO operations related to the <tt>Category</tt> entity.
 * 
 * @see Category
 * @author Christian Bauer
 */
public interface CategoryDAO extends GenericDAO<Category, Long> {

	public Collection<Category> findAll(boolean onlyRootCategories);

}
