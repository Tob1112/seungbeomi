package org.barista.domain.sample;

import static org.junit.Assert.*;

import java.util.Collection;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration
public class PersonDaoTest {

	@Autowired private PersonDao personDao;

	@Test
	public void testHibernateJpa() {
		assertNotNull(personDao);
		
		Collection<DefaultPerson> persons = personDao.findPersons();
		
		assertEquals(2, persons.size());
		
		for (DefaultPerson person : persons) {
			System.out.println(person);
		}
		
	}
}
