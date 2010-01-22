package com.prms.dao.impl;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import com.prms.dao.AccountUserDao;
import com.prms.model.Account;
import com.prms.model.AccountUser;
import com.prms.util.Md5Encrypt;

import flex.messaging.FlexContext;
import flex.messaging.FlexSession;

public class AccountUserDaoImpl extends SqlMapClientDaoSupport implements AccountUserDao {

	public boolean updateAccount(AccountUser account) {

		// Flex側のsession宣言
		FlexSession session = FlexContext.getFlexSession();

		// session値取得
		Account accountSession = (Account) session.getAttribute("account");

		// 返却値初期化
		boolean accountResult = false;
		// パスワード変更sql実行結果取得用変数を初期化
		Object result = null;
		// ユーザー情報セレクトsql実行結果取得用変すを初期化
		int selectResult = 0;
		// セッションからsql実行時必要な項目を設定する
		account.setEmpNo(accountSession.getEmpNo());
		//既存パスワードの 暗号化を行う
		account.setAccountUserPassword(Md5Encrypt.encryptingPassword(account.getAccountUserPassword()));
		//新パスワードの暗号化を行う
		account.setAccountUserNewPassword(Md5Encrypt.encryptingPassword(account.getAccountUserNewPassword()));

		// ユーザーが入力したデータを比較を行う
		selectResult = getSqlMapClientTemplate().queryForList("accountUserPasswordModifyUser.getAccount", account).size();

		// 検索されたデータがある場合
		if (selectResult != 0){

			// パスワードを変更する
			result = getSqlMapClientTemplate().update("accountUserPasswordModifyUser.updateAccount", account);
		}

		// 変更に成功した場合
		if (result != null) {
			// 返却値を「true」に設定
			accountResult = true;
		}
		// リターン
		return accountResult;
	}
}