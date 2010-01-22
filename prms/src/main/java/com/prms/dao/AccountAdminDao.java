package com.prms.dao;

import java.util.List;

import com.prms.model.AccountUser;
import com.prms.model.Message;

public interface AccountAdminDao {

	/**
	 * 社員リストメッソド
	 * @param AccountUser
	 */
	public List<AccountUser> accountAdminList(AccountUser account);

	/**
	 * 社員登録メッソド
	 * @param AccountUser
	 */
	public Message saveAccountAdminUser(AccountUser account);
}