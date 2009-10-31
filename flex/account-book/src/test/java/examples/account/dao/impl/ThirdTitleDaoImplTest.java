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

import examples.account.dao.ThirdTitleDao;
import examples.account.entity.ThirdTitle;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"/test-application-context.xml", "/test-data-access-context.xml", "/test-sql-map-config.xml"})
public class ThirdTitleDaoImplTest {

	final Logger logger = LoggerFactory.getLogger(ThirdTitleDaoImplTest.class);

	@Autowired
	private ThirdTitleDao thirdTitleDao;

	@Test
	public void testFindAccountEntries() {
		assertNotNull("thirdTitleDao is null", thirdTitleDao);

		List<ThirdTitle> result = thirdTitleDao.findAll();

		assertNotNull("result is null", result);

		Iterator<ThirdTitle> iter = result.iterator();
		while(iter.hasNext()) {
			ThirdTitle thirdTitle = iter.next();
			logger.info(thirdTitle.toString());
		}
	}
}
