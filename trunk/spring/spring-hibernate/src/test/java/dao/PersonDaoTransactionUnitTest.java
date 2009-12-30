package dao;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

import java.sql.SQLException;
import java.util.Collection;
import java.util.List;
import java.util.Map;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import bean.Person;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.AbstractTransactionalJUnit4SpringContextTests;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.transaction.AfterTransaction;
import org.springframework.test.context.transaction.BeforeTransaction;
import org.springframework.test.context.transaction.TransactionConfiguration;
import org.springframework.transaction.annotation.Transactional;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:shared-context.xml", "classpath:PersonDaoTest-context.xml"})
@TransactionConfiguration
@Transactional
public class PersonDaoTransactionUnitTest extends AbstractTransactionalJUnit4SpringContextTests {

    final Logger logger = LoggerFactory.getLogger(PersonDaoTransactionUnitTest.class);

    protected static int SIZE = 2;
    protected static Integer ID = new Integer(1);
    protected static String NAME = "son";
    protected static String CHANGED_NAME = "seungbeomi";

    @Autowired
    protected PersonDao personDao = null;

    /**
     * Tests that the size and first record match what is expected
     * before the transaction.
     */
    @BeforeTransaction
    public void beforeTransaction() {
        testPerson(true, NAME);
    }

    /**
     * Tests person table and changes the first records last name.
     */
    @Test
    public void testHibernateTemplate() throws SQLException {
        assertNotNull("Person DAO is null.", personDao);

        Collection<Person> lPersons = personDao.findPersons();

        assertNotNull("Person list is null.", lPersons);
        assertEquals("Number of persons should be " + SIZE + ".", SIZE, lPersons.size());

        for (Person person : lPersons) {
            assertNotNull("Person is null.", person);

            if (ID.equals(person.getId())) {
                assertEquals("Person first name should be " + NAME + ".", NAME, person.getName());

                person.setName(CHANGED_NAME);

                personDao.save(person);
            }
        }
    }

    /**
     * Tests that the size and first record match what is expected
     * after the transaction.
     */
    @AfterTransaction
    public void afterTransaction() {
        testPerson(false, NAME);
    }

    /**
     * Tests person table.
     */
    protected void testPerson(boolean beforeTransaction, String matchLastName) {
        List<Map<String, Object>> lPersonMaps = simpleJdbcTemplate.queryForList("SELECT * FROM PERSON");

        assertNotNull("Person list is null.", lPersonMaps);
        assertEquals("Number of persons should be " + SIZE + ".", SIZE, lPersonMaps.size());

        Map<String, Object> hPerson = lPersonMaps.get(0);

        logger.debug((beforeTransaction ? "Before" : "After") + " transaction.  " + hPerson.toString());

        Integer id = (Integer)hPerson.get("ID");
        String name = (String)hPerson.get("NAME");

        if (ID.equals(id)) {
            assertEquals("Person first name should be " + NAME + ".", NAME, name);
        }
    }

}
