package com.prms.dao;

import com.prms.model.Account;

/**
 * @author 孫承範
 */
public interface SecurityDao {

	/**
	 * @param email
	 * @return
	 */
	public Account getAccountByEmail(String email);

}
