package examples.account.dao.impl;

import static org.junit.Assert.assertNotNull;

import java.sql.Date;
import java.util.Iterator;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import examples.account.dao.AccountDao;
import examples.account.entity.Account;
import examples.account.entity.GroupedAccount;
import examples.account.entity.TotalAccount;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"/test-application-context.xml", "/test-data-access-context.xml", "/test-sql-map-config.xml"})
public class AccountDaoImplTest {

	final Logger logger = LoggerFactory.getLogger(AccountDaoImplTest.class);

	@Autowired
	private AccountDao accountDao;

	@Test
	public void testFindAccountEntries() {
		assertNotNull("accountDao is null", accountDao);

		List<Account> result = accountDao.findAccountEntries(2009, 8);

		assertNotNull(result);

		Iterator<Account> iter = result.iterator();
		while(iter.hasNext()) {
			Account account = iter.next();
			logger.info(account.toString());
		}
	}

	@Test
	public void testFindGroupedAccounts() {
		assertNotNull("accountDao is null", accountDao);

		List<GroupedAccount> result = accountDao.findGroupedAccounts(2009, 8);

		assertNotNull(result);

		Iterator<GroupedAccount> iter = result.iterator();
		while(iter.hasNext()) {
			GroupedAccount groupedAccount = iter.next();
			logger.info(groupedAccount.toString());
		}
	}

	@Test
	public void testFindTodayAccounts() {
		assertNotNull("accountDao is null", accountDao);

		Date date = new Date(108,2,4);
		List<Account> result = accountDao.findTodayAccounts(date);

		assertNotNull("result is null", result);

		Iterator<Account> iter = result.iterator();
		while(iter.hasNext()) {
			Account account = iter.next();
			logger.info(account.toString());
		}
	}

	@Test
	public void testGetTotalAccount() {
		assertNotNull("accountDao is null", accountDao);

		TotalAccount result = accountDao.getTotalAccount(2009, 8);

		assertNotNull("result is null.", result);

		logger.info(result.toString());
	}

	@Test
	public void testInsert() {
		assertNotNull("accountDao is null", accountDao);

		Account testAccount = new Account();
		testAccount.setAccountId(1);
		testAccount.setTxdate(new Date(108,8,14));
		testAccount.setFirstTitle(3);
		testAccount.setSecondTitle(5);
		testAccount.setThirdTitle("testTitle");
		testAccount.setPrice(500);
		testAccount.setUserId(1);
		testAccount.setVersion(1);

		accountDao.insert(testAccount);

	}

	@Test
	public void testUpdate() {
		assertNotNull("accountDao is null", accountDao);

		Account testAccount = new Account();
		testAccount.setAccountId(1);
		testAccount.setTxdate(new Date(108,8,14));
		testAccount.setFirstTitle(3);
		testAccount.setSecondTitle(5);
		testAccount.setThirdTitle("testTitle");
		testAccount.setPrice(1000);
		testAccount.setUserId(1);
		testAccount.setVersion(1);

		accountDao.update(testAccount);

	}

	@Test
	public void testDelete() {

	}
}
