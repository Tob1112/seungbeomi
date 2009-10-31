package examples.account.service;

import java.util.List;

import examples.account.dto.TitlesDto;
import examples.account.entity.Account;
import examples.account.entity.GroupedAccount;
import examples.account.entity.TotalAccount;

public interface AccountBookService {

	/**
	 * 家計簿データを返します。
	 * @return List<Account>
	 */
	List<Account> findAccountEntries(int txyear, int txmonth);

	List<Account> findTodayAccounts();
	
	/**
	 * 家計簿データの総計を返します。
	 * @return TotalAccount
	 */
	TotalAccount getTotalAccount(int txyear, int txmonth);

	/**
	 * カテゴリ別の家計簿データを返します。
	 * @return List<Account>
	 */
	List<GroupedAccount> findGroupedAccounts(int txyear, int txmonth);

	void doUpdate(Account account);

	void doInsert(Account account);

	void doDelete(Account account);

	TitlesDto findTitles();
	
	void doInsertAll(List<Account> accounts);

}
