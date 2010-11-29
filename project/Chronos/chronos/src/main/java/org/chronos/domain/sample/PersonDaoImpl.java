package org.chronos.domain.sample;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

public class PersonDaoImpl extends SqlMapClientDaoSupport implements PersonDao {

	private static final String SQL_ID_PREFIX 		= "Person.";
	private static final String SELECT_ID_LIST		= SQL_ID_PREFIX + "list";
	private static final String SELECT_ID_GET		= SQL_ID_PREFIX + "get";
	private static final String INSERT_ID_ADD		= SQL_ID_PREFIX + "add";
	private static final String UPDATE_ID_UPDATE	= SQL_ID_PREFIX + "update";
	private static final String DELETE_ID_DELETE	= SQL_ID_PREFIX + "delete";

	private static final String PARAMETER_NAME_ID	= "id";
	private static final String PARAMETER_NAME_NAME	= "name";

	@Override
	public List<Person> list() {
		return getSqlMapClientTemplate().queryForList(SELECT_ID_LIST);
	}

	@Override
	public Person get(int id) {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put(PARAMETER_NAME_ID, id);

		return (Person) getSqlMapClientTemplate().queryForObject(SELECT_ID_GET, parameters);
	}

	@Override
	public void add(Person person) {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put(PARAMETER_NAME_ID, person.getId());
		parameters.put(PARAMETER_NAME_NAME, person.getName());

		getSqlMapClientTemplate().insert(INSERT_ID_ADD, parameters);
	}

	@Override
	public void update(Person person) {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put(PARAMETER_NAME_ID, person.getId());
		parameters.put(PARAMETER_NAME_NAME, person.getName());

		getSqlMapClientTemplate().update(UPDATE_ID_UPDATE, parameters);
	}

	@Override
	public void delete(int id) {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put(PARAMETER_NAME_ID, id);

		getSqlMapClientTemplate().delete(DELETE_ID_DELETE, parameters);
	}

}
