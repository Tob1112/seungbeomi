package org.flora.dao.hibernate;

import java.io.Serializable;

import org.flora.dao.GenericDao;

public interface HibernateDao<T, PK extends Serializable> extends GenericDao<T, PK> {

	/** Synchronize Hibernate session with database
	 *	@see org.hibernate.Session#flush()
	 */
	void flush();

	/** Clear Hibernate session
	 *	@see org.hibernate.Session#clear()
	 */
	void clear();

	/** Synchronize Hibernate session with database and clear Hibernate session. */
	void flushAndClear();

	/**
	 * Hibernate session's update is actually reattaching.
	 * @see org.hibernate.Session#update(Object)
	 */
	void reattach(T entity);

	/**
	 * Evict entity form Hibernate's Session Context
	 * @param entity the corresponding Domain object.
	 * @see org.hibernate.Session#evict(Object)
	 */
	void evict(T entity);
}