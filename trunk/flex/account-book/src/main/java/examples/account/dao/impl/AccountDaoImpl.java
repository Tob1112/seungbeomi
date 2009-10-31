package examples.account.dao.impl;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import examples.account.dao.AccountDao;
import examples.account.entity.Account;
import examples.account.entity.GroupedAccount;
import examples.account.entity.TotalAccount;

@Repository
@Transactional(propagation=Propagation.SUPPORTS, readOnly=true)
public class AccountDaoImpl extends SqlMapClientDaoSupport implements AccountDao {

	@SuppressWarnings("unchecked")
	@Transactional(propagation=Propagation.SUPPORTS, readOnly=true)
	public List<Account> findAccountEntries(int txyear, int txmonth) {
		Map<String, Integer> param = new HashMap<String, Integer>(2);
		param.put("txyear", txyear);
		param.put("txmonth", txmonth);
		return getSqlMapClientTemplate().queryForList("Account.findAccountEntries", param);
	}

	@SuppressWarnings("unchecked")
	@Transactional(propagation=Propagation.SUPPORTS, readOnly=true)
	public List<GroupedAccount> findGroupedAccounts(int txyear, int txmonth) {
		Map<String, Integer> param = new HashMap<String, Integer>(2);
		param.put("txyear", txyear);
		param.put("txmonth", txmonth);
		return getSqlMapClientTemplate().queryForList("Account.findGroupedAccounts", param);
	}

	@SuppressWarnings("unchecked")
	@Transactional(propagation=Propagation.SUPPORTS, readOnly=true)
	public List<Account> findTodayAccounts(Date txdate) {
		return getSqlMapClientTemplate().queryForList("Account.findTodayAccounts", txdate);
	}

	@Transactional(propagation=Propagation.SUPPORTS, readOnly=true)
	public TotalAccount getTotalAccount(int txyear, int txmonth) {
		Map<String, Integer> param = new HashMap<String, Integer>(2);
		param.put("txyear", txyear);
		param.put("txmonth", txmonth);
		return (TotalAccount) getSqlMapClientTemplate().queryForObject("Account.getTotalAccount", param);
	}

	@Transactional(propagation=Propagation.REQUIRED, readOnly=false)
	public void insert(Account account) {
		getSqlMapClientTemplate().insert("Account.insert", account);
	}

	@Transactional(propagation=Propagation.REQUIRED, readOnly=false)
	public void update(Account account) {
		getSqlMapClientTemplate().update("Account.update", account);
	}

	@Transactional(propagation=Propagation.REQUIRED, readOnly=false)
	public void delete(Account account) {
		getSqlMapClientTemplate().delete("Account.delete", account);
	}

}
