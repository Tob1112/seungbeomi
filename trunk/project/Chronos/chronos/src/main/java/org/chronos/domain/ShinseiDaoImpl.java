package org.chronos.domain;

import java.util.HashMap;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

public class ShinseiDaoImpl extends SqlMapClientDaoSupport implements ShinseiDao{

	private static final Logger log = Logger.getLogger(ShinseiDaoImpl.class);

	private static final String SQL_ID_PREFIX 				= "Shinsei.";
	private static final String INSERT_ID_ADD_SHINSEI 		= SQL_ID_PREFIX + "addShinsei";
	private static final String SELECT_ID_GET_SHINSEI 		= SQL_ID_PREFIX + "getShinsei";

	private static final String PARAMETER_NAME_SHINSEI_BANGO 	= "shinseiBango";
	private static final String PARAMETER_NAME_SHAIN_ID 		= "shainId";
	private static final String PARAMETER_NAME_SHINSEI_KUBUN 	= "shinseiKubun";
	private static final String PARAMETER_NAME_SHINSEI_JOKYO 	= "shinseiJokyo";
	private static final String PARAMETER_NAME_SHINSEI_FILE 	= "shinseiFile";
	private static final String PARAMETER_NAME_SHINSEI_KEKKA 	= "shinseiKekka";

	@Override
	public Shinsei addShinsei(Shinsei shinsei) {

		Shinsei reload = null;

		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters = ShinseiMapper.mapping(shinsei);
		getSqlMapClientTemplate().insert(INSERT_ID_ADD_SHINSEI, parameters);

		parameters.clear();
		parameters.put(PARAMETER_NAME_SHINSEI_BANGO, shinsei.getShinseiBango());
		ShinseiDto result = (ShinseiDto) getSqlMapClientTemplate().queryForObject(SELECT_ID_GET_SHINSEI, parameters);

		if (result != null) {
			reload = ShinseiMapper.mapping(result);
		}

		System.out.println("reload : " + reload.getShainId());

		return reload;
	}
}
