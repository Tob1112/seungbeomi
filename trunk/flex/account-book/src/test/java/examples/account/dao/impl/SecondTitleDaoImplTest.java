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

import examples.account.dao.SecondTitleDao;
import examples.account.entity.SecondTitle;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"/test-application-context.xml", "/test-data-access-context.xml", "/test-sql-map-config.xml"})
public class SecondTitleDaoImplTest {

	final Logger logger = LoggerFactory.getLogger(SecondTitleDaoImplTest.class);

	@Autowired
	private SecondTitleDao secondTitleDao;

	@Test
	public void testFindAccountEntries() {
		assertNotNull("secondTitleDao is null", secondTitleDao);

		List<SecondTitle> result = secondTitleDao.findAll();

		assertNotNull("result is null", result);

		Iterator<SecondTitle> iter = result.iterator();
		while(iter.hasNext()) {
			SecondTitle secondTitle = iter.next();
			logger.info(secondTitle.toString());
		}
	}
}
