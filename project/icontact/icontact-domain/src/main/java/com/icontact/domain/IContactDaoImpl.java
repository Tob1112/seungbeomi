package com.icontact.domain;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

public class IContactDaoImpl extends SqlMapClientDaoSupport implements IContactDao {

	private static final String SQL_ID_PREFIX    = "Contact.";
	private static final String SELECT_ID_FIND   = SQL_ID_PREFIX + "find";
	private static final String SELECT_ID_FINDS  = SQL_ID_PREFIX + "finds";
	private static final String INSERT_ID_ADD    = SQL_ID_PREFIX + "add";
	private static final String UPDATE_ID_UPDATE = SQL_ID_PREFIX + "update";
	private static final String DELETE_ID_DELETE = SQL_ID_PREFIX + "delete";

	private static final String PARAMETER_NAME_NAME          = "name";
	private static final String PARAMETER_NAME_PHONE         = "phone";
	private static final String PARAMETER_NAME_EMAIL         = "email";
	private static final String PARAMETER_NAME_ADDRESS       = "address";
	private static final String PARAMETER_NAME_NOTES         = "notes";
	private static final String PARAMETER_NAME_STATUS        = "status";
	private static final String PARAMETER_NAME_ACCOUNT       = "account";

	@Override
	public Contact find(Contact contact) {
		Map<String, Object> parameters;

		parameters = new HashMap<String, Object>();
		parameters.put(PARAMETER_NAME_NAME, contact.getName());
		parameters.put(PARAMETER_NAME_ACCOUNT, contact.getAccount());

		return (Contact) getSqlMapClientTemplate().queryForObject(SELECT_ID_FIND, parameters);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Contact> finds(String account) {
		Map<String, Object> parameters;

		parameters = new HashMap<String, Object>();
		parameters.put(PARAMETER_NAME_ACCOUNT, account);

		return getSqlMapClientTemplate().queryForList(SELECT_ID_FINDS, parameters);
	}

	@Override
	public void add(Contact contact) {
		Map<String, Object> parameters;

		parameters = new HashMap<String, Object>();
		parameters.put(PARAMETER_NAME_NAME, contact.getName());
		parameters.put(PARAMETER_NAME_PHONE, contact.getPhone());
		parameters.put(PARAMETER_NAME_EMAIL, contact.getEmail());
		parameters.put(PARAMETER_NAME_ADDRESS, contact.getAddress());
		parameters.put(PARAMETER_NAME_NOTES, contact.getNotes());
		parameters.put(PARAMETER_NAME_STATUS, contact.getStatus());
		parameters.put(PARAMETER_NAME_ACCOUNT, contact.getAccount());

		getSqlMapClientTemplate().insert(INSERT_ID_ADD, parameters);
	}

	@Override
	public void update(Contact contact) {
		Map<String, Object> parameters;

		parameters = new HashMap<String, Object>();
		parameters.put(PARAMETER_NAME_NAME, contact.getName());
		parameters.put(PARAMETER_NAME_PHONE, contact.getPhone());
		parameters.put(PARAMETER_NAME_EMAIL, contact.getEmail());
		parameters.put(PARAMETER_NAME_ADDRESS, contact.getAddress());
		parameters.put(PARAMETER_NAME_NOTES, contact.getNotes());
		parameters.put(PARAMETER_NAME_STATUS, contact.getStatus());
		parameters.put(PARAMETER_NAME_ACCOUNT, contact.getAccount());

		getSqlMapClientTemplate().update(UPDATE_ID_UPDATE, parameters);
	}

	@Override
	public void delete(Contact contact) {
		Map<String, Object> parameters;

		parameters = new HashMap<String, Object>();
		parameters.put(PARAMETER_NAME_NAME, contact.getName());
		parameters.put(PARAMETER_NAME_ACCOUNT, contact.getAccount());

		getSqlMapClientTemplate().delete(DELETE_ID_DELETE, parameters);
	}
}
