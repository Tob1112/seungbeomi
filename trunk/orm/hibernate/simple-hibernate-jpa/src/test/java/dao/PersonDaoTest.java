package dao;

import static org.junit.Assert.*;

import java.util.Collection;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import bean.Person;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration
public class PersonDaoTest {

	final Logger logger = LoggerFactory.getLogger(PersonDaoTest.class);

	@Autowired
	private PersonDao personDao;

	@Test
	public void testGetPersonList() {
		assertNotNull(personDao);

		Collection<Person> personList = personDao.getPersonList();

		int expectedSize = 2;

		assertNotNull(personList);
		assertEquals(expectedSize, personList.size());
	}

}
