package org.flora.service.impl;

import java.io.Serializable;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.flora.dao.GenericDao;
import org.flora.service.GenericManager;

public class GenericManagerImpl<T, PK extends Serializable> implements GenericManager<T, PK> {

	protected final Log log = LogFactory.getLog(getClass());
	protected GenericDao dao = null;

	@Override
	public void setDao(T object) {
		this.dao = (GenericDao) object;
	}

	@Override
	public List<T> getAll(T object) {
		return dao.getAll(object);
	}

	@Override
	public T get(T object, PK id) {
		return (T) dao.get(object, id);
	}

	@Override
	public void save(T object) {
		dao.save(object);
	}

	@Override
	public void remove(T object, PK id) {
		dao.remove(object, id);
	}
}
