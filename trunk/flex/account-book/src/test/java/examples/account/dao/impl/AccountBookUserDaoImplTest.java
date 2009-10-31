package examples.account.dao.impl;

import static org.junit.Assert.assertNotNull;

import java.util.Iterator;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import examples.account.dao.AccountBookUserDao;
import examples.account.entity.AccountBookUser;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"/test-application-context.xml", "/test-data-access-context.xml", "/test-sql-map-config.xml"})
public class AccountBookUserDaoImplTest {

	final Logger logger = LoggerFactory.getLogger(AccountBookUserDaoImplTest.class);

	@Autowired
	private AccountBookUserDao accountBookUserDao = null;

	@Test
	public void findAll() {
		assertNotNull("AccountBookUserDao is null", accountBookUserDao);

		List<AccountBookUser> result = accountBookUserDao.findAll();

		assertNotNull("result is null", result);

		Iterator<AccountBookUser> iter = result.iterator();

		while(iter.hasNext()) {
			AccountBookUser accountBookUser = iter.next();
			logger.info(accountBookUser.toString());
		}
	}

	@Test
	public void testGetCount() {
		assertNotNull("AccountBookUserDao is null", accountBookUserDao);

		Integer result = accountBookUserDao.getCount();

		logger.info("result = " + result);

		//assertEquals(3, result);
		//assertNotNull("result is null", result);

		//assertEquals((Integer) 3, result);
	}
}
