package dao;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

import java.sql.SQLException;
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
@ContextConfiguration(locations={"classpath:shared-context.xml", "classpath:PersonDaoTest-context.xml"})
public class PersonDaoTransactionTest {

	final Logger logger = LoggerFactory.getLogger(PersonDaoTransactionTest.class);

	private static int SIZE = 2;
	private static Integer ID = new Integer(1);
	private static String NAME = "son";
	private static String CHANGED_NAME = "seungbeomi";

	@Autowired
	private PersonDao personDao = null;

	@Test
	public void testSave() throws SQLException {
		 assertNotNull("Person DAO is null.", personDao);

	        Collection<Person> lPersons = personDao.findPersons();

	        assertNotNull("Person list is null.", lPersons);
	        assertEquals("Number of persons should be " + SIZE + ".", SIZE, lPersons.size());

	        for (Person person : lPersons) {
	            assertNotNull("Person is null.", person);

	            if (ID.equals(person.getId())) {
	                assertEquals("Person name should be " + NAME + ".", NAME, person.getName());

	                person.setName(CHANGED_NAME);

	                personDao.save(person);
	            }
	        }
	}
}
