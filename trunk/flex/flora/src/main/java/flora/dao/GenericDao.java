package flora.dao;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

public interface GenericDao <T, PK extends Serializable> {

	List<T> getAll();

	T get(PK id);

	boolean exists(PK id);

	T save(T object);

	void remove(PK id);

	List<T> findByNamedQuery(String queryName, Map<String, Object> queryParams);

}
