package org.flora.service.impl;

import java.io.Serializable;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.flora.dao.Dao;
import org.flora.service.Manager;

public class BaseManager implements Manager{

	protected final Log log = LogFactory.getLog(getClass());
	protected Dao dao = null;

	@Override
	public void setDao(Dao dao) {
		this.dao = dao;
	}

	@Override
	public List getAll(Class clazz) {
		return dao.getAll(clazz);
	}

	@Override
	public Object get(Class clazz, Serializable id) {
		return dao.get(clazz, id);
	}

	@Override
	public void save(Object object) {
		dao.save(object);

	}

	@Override
	public void remove(Class clazz, Serializable primaryKey) {
		dao.remove(clazz, primaryKey);
	}
}
