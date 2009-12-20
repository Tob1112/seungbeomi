package org.flora.dao;

import java.io.Serializable;
import java.util.List;

public interface Dao {

	public List getAll(Class clazz);

	public Object get(Class clazz, Serializable primaryKey);

	public List getRoles(Object object);

	public boolean exists(Class clazz, Serializable primaryKey);

	public void save(Object object);

	public void remove(Class clazz, Serializable primaryKey);


}
