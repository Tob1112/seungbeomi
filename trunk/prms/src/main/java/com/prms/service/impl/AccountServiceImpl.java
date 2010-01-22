package com.prms.service.impl;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

import com.prms.dao.AccountAdminDao;
import com.prms.dao.AccountUserDao;
import com.prms.exception.PrmsException;
import com.prms.model.Account;
import com.prms.model.AccountUser;
import com.prms.model.Message;
import com.prms.service.AccountService;
import com.prms.util.MessageUtil;
import com.prms.util.Validator;

import flex.messaging.FlexContext;
import flex.messaging.FlexSession;

/**
 * 人事管理クラス
 */
public class AccountServiceImpl implements AccountService {

	/** ユーザーパスワード変更DAO */
	private AccountUserDao accountUserDao;

	/** 人事管理DAO(insert,select) */
	private AccountAdminDao accountAdminDao;

	/**
	 * ユーザーパスワード変更
	 *
	 * @param AccountUser
	 *            : アカウント
	 */
	public boolean updateAccount(AccountUser account) {
		return accountUserDao.updateAccount(account);
	}

	/**
	 * 人事管理→社員リスト(管理者)
	 *
	 * @param AccountUser
	 *            : アカウント
	 */
	public List<AccountUser> accountAdminList(AccountUser account) {
		return accountAdminDao.accountAdminList(account);
	}

	/**
	 * セッションからユーザー情報取得
	 *
	 * @return accountUser
	 */
	public AccountUser accountUserInfo() {

		AccountUser accountUser = new AccountUser();

		Calendar calendar = Calendar.getInstance();
		Date currentDate = (Date) calendar.getTime();

		// Flex側のsession宣言
		FlexSession session = FlexContext.getFlexSession();

		// session値取得
		Account accountSession = (Account) session.getAttribute("account");

		// セッションからsql実行時必要な項目を設定する
		accountUser.setFirstName(accountSession.getFirstName());
		accountUser.setLastName(accountSession.getLastName());
		accountUser.setEmpNo(accountSession.getEmpNo());
		accountUser.setEmail(accountSession.getEmail() + "@roue.co.jp");
		accountUser.setCurrentDate(currentDate);

		return accountUser;
	}

	/**
	 * エラーメッセージ
	 */
	public Message saveAccountAdminUser(AccountUser account) {

		Message message;

		//妥当性チェックを行う
		message = validateSaveUser(account);

		// エラーの場合
		if (message != null) {
			return message;
		}

		// アカウント情報を保存する
		message = accountAdminDao.saveAccountAdminUser(account);

		// エラーの場合
		if (message != null) {
			return message;
		}

		// 正常終了のメッセージを返却
		return MessageUtil.getMessage("I", "0002");
	}

	public AccountAdminDao getAccountAdminDao() {
		return accountAdminDao;
	}

	public void setAccountAdminDao(AccountAdminDao accountAdminDao) {
		this.accountAdminDao = accountAdminDao;
	}

	public AccountUserDao getAccountUserDao() {
		return accountUserDao;
	}

	public void setAccountUserDao(AccountUserDao accountUserDao) {
		this.accountUserDao = accountUserDao;
	}

	/**
	 *ユーザー登録妥当性検証メッソド
	 *
	 * @param AccountUser ユーザーアカウントドメイン
	 * @author 宋珠憲
	 */
	private Message validateSaveUser(AccountUser account) {

		// 社員番号入力チェック
		if (Validator.isEmpty(account.getEmpNo())) {
			validatorFailMessage("E", "0100");
		}
		// 社員番号タイプチェック(数字)
		else if (!Validator.isNumber(account.getEmpNo())) {
			validatorFailMessage("E", "0101");
		}
		// 社員番号桁数チェック(4桁以下)
		else if (!Validator.isByteLengthOfOverCharacter(account.getEmpNo(),4)){
			validatorFailMessage("E", "0102");
		}
		// 社員名(姓)空)チェック
		else if (Validator.isEmpty(account.getLastName())){
			validatorFailMessage("E", "0103");
		}
		// 社員名(名)空)チェック
		else if (Validator.isEmpty(account.getFirstName())){
			validatorFailMessage("E", "0104");
		}
		// 社員名(姓)桁数)
		else if (!Validator.isByteLengthOfOverCharacter(account.getLastName(),64)){
			validatorFailMessage("E", "0105");
		}
		// 社員名(名)桁数)
		else if (!Validator.isByteLengthOfOverCharacter(account.getFirstName(),64)){
			validatorFailMessage("E", "0106");
		}
		// 入社日(空):日付形式だけ入力できるので空チェックだけでOK
		else if (Validator.isEmpty(account.getHireDay())){
			validatorFailMessage("E", "0107");
		}
		// メール(空)
		else if (Validator.isEmpty(account.getEmail())){
			validatorFailMessage("E", "0108");
		}
		// メール(タイプ)
		else if (!Validator.isEnglishAndNumber(account.getEmail())){
			validatorFailMessage("E", "0109");
		}
		// メール(桁数)
		else if (!Validator.isByteLengthOfOverCharacter(account.getEmail(),64)){
			validatorFailMessage("E", "0110");
		}

		return null;
	}

	/**
	 * 妥当性エラーを表示
	 * @param msgType
	 * @param msgId
	 */
	private void validatorFailMessage(String msgType, String msgId) {
		Message message = MessageUtil.getMessage(msgType, msgId);
		throw new PrmsException(message.getMsgBody());
	}
}