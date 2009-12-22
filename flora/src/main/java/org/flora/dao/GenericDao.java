package org.flora.dao;

import java.io.Serializable;
import java.util.List;

public interface GenericDao<T, PK extends Serializable> {

	public List<T> getAll(T object);

	public T get(T object, PK id);

	public List<T> getRoles(T object);

	public boolean exists(T object, PK id);

	public void save(T object);

	public void remove(T object, PK id);

}
