package org.flora.dao;

import java.util.List;

public interface GenericDao<T, P> {

	public List<T> getAll(T object);

	public T get(T object, P id);

	public List<T> find(T object, T prameterObject);

	public List<T> getRoles(T object);

	public boolean exists(T object, P id);

	public void save(T object);

	public void remove(T object, P id);

}
