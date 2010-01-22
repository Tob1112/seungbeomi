package com.prms.dao;

import com.prms.model.AccountUser;

public interface AccountUserDao {

	/**
	 * ユーザーパスワード変更メッソド
	 * @param AccountUser
	 */
	public boolean updateAccount(AccountUser account);
}