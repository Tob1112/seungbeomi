package org.april27.orm.ibatis;

import java.io.Serializable;
import java.util.List;

public interface Dao {

	public List getAll(Class clazz);

	public Object get(Class clazz, Serializable primaryKey);

	//public List find(Class clszz, Object prameterObject);

	//public List<T> getRoles(T object);

	//public boolean exists(Clazz object, PK id);

	public void save(Object object);

	public void remove(Class clazz, Serializable primaryKey);

}
