package examples.account.dao;

import java.util.Date;
import java.util.List;

import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import examples.account.entity.Account;
import examples.account.entity.GroupedAccount;
import examples.account.entity.TotalAccount;

public interface AccountDao {

	@Transactional(propagation=Propagation.SUPPORTS, readOnly=true)
	List<Account> findAccountEntries(int txyear, int txmonth);

	@Transactional(propagation=Propagation.SUPPORTS, readOnly=true)
	TotalAccount getTotalAccount(int txyear, int txmonth);

	@Transactional(propagation=Propagation.SUPPORTS, readOnly=true)
	List<GroupedAccount> findGroupedAccounts(int txyear, int txmonth);

	@Transactional(propagation=Propagation.SUPPORTS, readOnly=true)
	List<Account> findTodayAccounts(Date txdate);

	@Transactional(propagation=Propagation.REQUIRED, readOnly=false)
	void insert(Account account);

	@Transactional(propagation=Propagation.REQUIRED, readOnly=false)
	void update(Account account);

	@Transactional(propagation=Propagation.REQUIRED, readOnly=false)
	void delete(Account account);

}
