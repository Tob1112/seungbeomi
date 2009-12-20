package org.flora.service;

import java.io.Serializable;
import java.util.List;

import org.flora.dao.Dao;

public interface Manager {

	public void setDao(Dao dao);

	public List getAll(Class clazz);

	public Object get(Class clazz, Serializable primaryKey);

	public void save(Object object);

	public void remove(Class clazz, Serializable primaryKey);
}
