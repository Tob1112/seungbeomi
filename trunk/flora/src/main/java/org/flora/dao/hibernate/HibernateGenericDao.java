package org.flora.dao.hibernate;

import java.io.Serializable;
import java.util.List;

public class HibernateGenericDao<T, PK extends Serializable> implements HibernateDao<T, PK> {

	//---------------------------------------------------
	// implements GenericDao method
	//---------------------------------------------------

	@Override
	public List<T> getAll(T object) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public T get(T object, PK id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<T> find(T object, T prameterObject) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<T> getRoles(T object) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean exists(T object, PK id) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public void save(T object) {
		// TODO Auto-generated method stub

	}

	@Override
	public void remove(T object, PK id) {
		// TODO Auto-generated method stub

	}

	//---------------------------------------------------
	// implements HibernateDao method
	//---------------------------------------------------

	@Override
	public void flush() {
		// TODO Auto-generated method stub

	}

	@Override
	public void clear() {
		// TODO Auto-generated method stub

	}

	@Override
	public void flushAndClear() {
		// TODO Auto-generated method stub

	}

	@Override
	public void reattach(T entity) {
		// TODO Auto-generated method stub

	}

	@Override
	public void evict(T entity) {
		// TODO Auto-generated method stub

	}
}
