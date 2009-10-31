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

import examples.account.dao.FirstTitleDao;
import examples.account.entity.FirstTitle;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"/test-application-context.xml", "/test-data-access-context.xml", "/test-sql-map-config.xml"})
public class FirstTitleDaoImplTest {

	final Logger logger = LoggerFactory.getLogger(FirstTitleDaoImplTest.class);

	@Autowired
	private FirstTitleDao firstTitleDao;

	@Test
	public void testFindAccountEntries() {
		assertNotNull("firstTitleDao is null", firstTitleDao);

		List<FirstTitle> result = firstTitleDao.findAll();

		assertNotNull("result is null", result);

		Iterator<FirstTitle> iter = result.iterator();
		while(iter.hasNext()) {
			FirstTitle firstTitle = iter.next();
			logger.info(firstTitle.toString());
		}
	}
}
