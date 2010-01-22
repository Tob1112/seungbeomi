package com.prms.dao.impl;

import java.sql.SQLException;
import java.util.List;

import org.springframework.orm.ibatis.SqlMapClientCallback;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import com.ibatis.sqlmap.client.SqlMapExecutor;
import com.prms.Constants;
import com.prms.dao.AccountAdminDao;
import com.prms.exception.PrmsException;
import com.prms.model.AccountUser;
import com.prms.model.Message;
import com.prms.util.MessageUtil;

public class AccountAdminDaoImpl extends SqlMapClientDaoSupport implements AccountAdminDao{

    public List<AccountUser> accountAdminList(AccountUser account) {
        return (List<AccountUser>)getSqlMapClientTemplate().queryForList("accountAdmin.getAccountAdminList", account);
    }

    public Message saveAccountAdminUser(final AccountUser account){

        // パスワードを初期値「roue!garcon」に設定する
        //account.setAccountUserPassword(Md5Encrypt.encryptingPassword("roue!garcon"));
    	account.setAccountUserPassword(Constants.INITIALIZE_PASSWORD);

        try {

        	// 会員番号を検索する
        	// 選択された会社に入力された社員番号がないかをチェックする
        	Integer duplicateEmpNo = (Integer) getSqlMapClientTemplate().queryForObject("accountAdmin.getAccountEmpNo", account);

        	// 検索結果がある場合
        	if (duplicateEmpNo >= 1) {
        		Message message = MessageUtil.getMessage("E", "0111");
        		throw new PrmsException(message.getMsgBody());
        	}
        	//社員番号が検索されてない場合
        	else {
        		getSqlMapClientTemplate().execute(new SqlMapClientCallback() {
					@Override
					public Object doInSqlMapClient(SqlMapExecutor executor)	throws SQLException {
						executor.startBatch();

						// 新規ユーザー登録(EMPテーブル)
						executor.insert("accountAdmin.saveAccountAdminUser", account);

						// user権限登録(AUTHテーブル)
						if (account.getRole().equals("01")) {

							// ユーザー権限設定
							account.setRole(Constants.ROLE_USER);
							executor.insert("accountAdmin.saveAccountAdminUserRole", account);

						}
						// 管理者権限登録(AUTHテーブル)
						// 管理者の場合ユーザーの権限と管理者の権限を登録
						else if (account.getRole().equals("02")) {

							// ユーザー権限設定
							account.setRole(Constants.ROLE_USER);
							executor.insert("accountAdmin.saveAccountAdminUserRole", account);

							// 管理者権限設定
							account.setRole(Constants.ROLE_ADMIN);
							executor.insert("accountAdmin.saveAccountAdminUserRole", account);

						}

						executor.executeBatch();
						return null;
					}

        		});
        	}
        } catch (Exception e) {
        	logger.error(e.toString());
        	Message message = MessageUtil.getMessage("E", "0112");
            // 登録の際エラーが発生した場合
    		throw new PrmsException(message.getMsgBody(), e);
        }

        return null;
    }
}