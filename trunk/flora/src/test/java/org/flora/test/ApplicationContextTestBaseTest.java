package org.flora.test;

import static org.junit.Assert.*;

import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.AbstractTransactionalJUnit4SpringContextTests;

@ContextConfiguration
public class ApplicationContextTestBaseTest extends AbstractTransactionalJUnit4SpringContextTests {

	final Logger logger = LoggerFactory.getLogger(getClass());

	private final String DATA_URL = "data.xml";

	@Autowired
	private ApplicationContextTestBase applicationContextTestBase;

	@Test
	public void testCleanInsertFlatXmlData() {
		assertNotNull("ApplicationContextTestBase is null.", applicationContextTestBase);
		try {
			applicationContextTestBase.cleanInsertFlatXmlData(DATA_URL);
		} catch (Exception e) {
			e.printStackTrace();
			fail("cleanInsertFlatXmlData is fail." + e);
		}
	}
}
