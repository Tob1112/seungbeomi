package com.prms.dao.impl;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import com.prms.dao.SecurityDao;
import com.prms.model.Account;

/**
 * @author 孫承範
 */
public class SecurityDaoImpl extends SqlMapClientDaoSupport implements SecurityDao {

	@Override
	public Account getAccountByEmail(String email) {
		return (Account) getSqlMapClientTemplate().queryForObject("account.getAccountByEmail", email);
	}

}
