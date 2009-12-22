package org.flora.service;

import java.io.Serializable;
import java.util.List;

public interface GenericManager<T, PK extends Serializable> {

	public void setDao(T object);

	public List<T> getAll(T object);

	public T get(T object, PK id);

	public void save(T object);

	public void remove(T object, PK id);
}
