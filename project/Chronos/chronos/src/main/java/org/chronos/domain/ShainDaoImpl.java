package org.chronos.domain;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

public class ShainDaoImpl extends SqlMapClientDaoSupport implements ShainDao {

	private static final Logger log = Logger.getLogger(ShainDaoImpl.class);

	private static final String SQL_ID_PREFIX 				= "Shain.";
	private static final String SELECT_ID_FIND_SHAIN_ALL	= SQL_ID_PREFIX + "findShainAll";
	private static final String SELECT_ID_FIND_SAHIN		= SQL_ID_PREFIX + "findShain";
	private static final String INSERT_ID_ADD_SHAIN			= SQL_ID_PREFIX + "addShain";
	private static final String UPDATE_ID_UPDATE_SHAIN		= SQL_ID_PREFIX + "updateShain";
	private static final String DELETE_ID_REMOVE_SHAIN		= SQL_ID_PREFIX + "removeShain";

	private static final String PARAMETER_NAME_ID			= "id";
	private static final String PARAMETER_NAME_PASSWORD		= "password";
	private static final String PARAMETER_NAME_NAME			= "name";
	private static final String PARAMETER_NAME_SHAIN_MEI	= "shainMei";
	private static final String PARAMETER_NAME_SHAIN_BANGO	= "shainBango";
	private static final String PARAMETER_NAME_ROLE			= "role";

	@Override
	public Shain findShain(Shain shain) {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put(PARAMETER_NAME_ID, shain.getId());
		parameters.put(PARAMETER_NAME_PASSWORD, shain.getPassword());

		return (Shain) getSqlMapClientTemplate().queryForObject(SELECT_ID_FIND_SAHIN, parameters);
	}

	@Override
	public List<List> findShainAll() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void removeShain(Shain shain) {
		// TODO Auto-generated method stub

	}

	@Override
	public Shain saveShain(Shain shain) {
		// TODO Auto-generated method stub
		return null;
	}

}
