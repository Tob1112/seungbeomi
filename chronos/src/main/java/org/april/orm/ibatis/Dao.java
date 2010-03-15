package org.april.orm.ibatis;

import java.io.Serializable;
import java.util.List;

public interface Dao {

	List getAll(Class clazz);

	Object get(Class clazz, Serializable primaryKey);

	//List find(Class clszz, Object prameterObject);

	//List<T> getRoles(T object);

	//boolean exists(Clazz object, PK id);

	void save(Object object);

	void update(Class clazz);

	void remove(Class clazz, Serializable primaryKey);

}
