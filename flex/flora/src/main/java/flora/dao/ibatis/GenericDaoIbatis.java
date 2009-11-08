package flora.dao.ibatis;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import com.ibatis.sqlmap.client.SqlMapClient;

import flora.dao.GenericDao;

public class GenericDaoIbatis<T, PK extends Serializable> extends SqlMapClientDaoSupport implements GenericDao<T, PK> {

	protected final Log log = LogFactory.getLog(getClass());
	private Class<T> persistentClass;

	@Autowired
	public GenericDaoIbatis(final Class<T> persistentClass, SqlMapClient sqlMapClient) {
		super();
		this.persistentClass = persistentClass;
		this.setSqlMapClient(sqlMapClient);

	}

	@Override
	public boolean exists(Serializable id) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public List<T> findByNamedQuery(String queryName,
			Map<String, Object> queryParams) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public T get(Serializable id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<T> getAll() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void remove(Serializable id) {
		// TODO Auto-generated method stub

	}

	@Override
	public T save(T object) {
		// TODO Auto-generated method stub
		return null;
	}

}
