package examples.account.service.impl;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.flex.remoting.RemotingDestination;
import org.springframework.stereotype.Service;

import examples.account.dao.AccountDao;
import examples.account.dao.FirstTitleDao;
import examples.account.dao.SecondTitleDao;
import examples.account.dao.ThirdTitleDao;
import examples.account.dto.TitlesDto;
import examples.account.entity.Account;

import examples.account.entity.FirstTitle;
import examples.account.entity.GroupedAccount;
import examples.account.entity.SecondTitle;
import examples.account.entity.ThirdTitle;
import examples.account.entity.TotalAccount;
import examples.account.service.AccountBookService;

@Service("accountBookService")
@RemotingDestination
public class AccountBookServiceImpl implements AccountBookService {

	@Autowired
	public AccountDao accountDao;
	@Autowired
	public FirstTitleDao firstTitleDao;
	@Autowired
	public SecondTitleDao secondTitleDao;
	@Autowired
	public ThirdTitleDao thirdTitleDao;

	public void doDelete(Account account) {
		accountDao.delete(account);
	}

	public List<Account> findAccountEntries(int txyear, int txmonth) {
		List<Account> accounts = accountDao.findAccountEntries(txyear, txmonth);
		return accounts;
	}

	public TotalAccount getTotalAccount(int txyear, int txmonth) {
		TotalAccount totalAccount = accountDao.getTotalAccount(txyear, txmonth);
		return totalAccount;
	}

	public List<GroupedAccount> findGroupedAccounts(int txyear, int txmonth) {
		List<GroupedAccount> groups = accountDao.findGroupedAccounts(txyear, txmonth);
		return groups;
	}

	public void doInsert(Account account) {
		accountDao.insert(account);
	}

	public void doUpdate(Account account) {
		accountDao.update(account);
	}

	public TitlesDto findTitles() {

		List<FirstTitle> firstTitleList = firstTitleDao.findAll();
		List<SecondTitle> secondTitleList = secondTitleDao.findAll();
		List<ThirdTitle> thirdTitleList = thirdTitleDao.findAll();

		TitlesDto dto = new TitlesDto();
		dto.firstTitleList = firstTitleList;
		dto.secondTitleList = secondTitleList;
		dto.thirdTitleList = thirdTitleList;

		return dto;
	}

	public List<Account> findTodayAccounts() {
		return accountDao.findTodayAccounts(new Date());
	}

	public void doInsertAll(List<Account> accounts) {
		if(accounts == null){
			throw new IllegalArgumentException("no acccounts given.");
		}
		for(Account account : accounts) {
			accountDao.insert(account);
		}
	}

}
