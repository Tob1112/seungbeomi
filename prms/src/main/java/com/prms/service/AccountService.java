package com.prms.service;

import com.prms.model.AccountUser;
import com.prms.model.Message;

import java.sql.SQLException;
import java.util.List;

/**
 * アカウントインターフェイス
 *
 * @author
 * @author
 */
public interface AccountService {

	/**
	 * ユーザーパスワード変更
	 *
	 * @param AccountUser
	 * @author
	 */
	public boolean updateAccount(AccountUser account);

	/**
	 * 社員リスト
	 *
	 * @param AccountUser
	 * @author
	 */
	public List<AccountUser> accountAdminList(AccountUser account);

	/**
	 * 社員新規登録
	 *
	 * @param AccountUser
	 * @author
	 */
	public Message saveAccountAdminUser(AccountUser account);

	/**
	 * 社員情報取得
	 *
	 * @param
	 * @author
	 */
	public AccountUser accountUserInfo();

}