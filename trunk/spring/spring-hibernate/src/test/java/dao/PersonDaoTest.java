package dao;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

import java.sql.SQLException;
import java.util.Collection;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import bean.Address;
import bean.Person;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:shared-context.xml", "classpath:PersonDaoTest-context.xml"})
public class PersonDaoTest {

    final Logger logger = LoggerFactory.getLogger(PersonDaoTest.class);

    @Autowired
    protected PersonDao personDao = null;

    @Test
    public void testHibernateTemplate() throws SQLException {
    	// test대상 dao의 null 확인
        assertNotNull("Person DAO is null.", personDao);

        Collection<Person> lPersons = personDao.findPersons();

        int expected = 2;

        assertNotNull("Person list is null.", lPersons); // 결과 null확인
        assertEquals("Number of persons should be " + expected + ".", expected, lPersons.size()); //결과 collection의 size확인

        // 테스트대상 id 설정
        Integer firstId = new Integer(1);
        Integer secondId = new Integer(2);

        for (Person person : lPersons) {
            assertNotNull("Person is null.", person); // 결과 객체

            // 첫번째 person 테스트
            if (firstId.equals(person.getId())) {
                String name = "son";

                int expectedAddresses = 1;

            	assertEquals("Person name should be " + name + ".", name, person.getName());

                assertNotNull("Person's address list is null.", person.getAddresses());
                assertEquals("Number of person's address list should be " + expectedAddresses + ".", expectedAddresses, person.getAddresses().size());

                Integer addressId = new Integer(1);
                String addr = "pusan";

                for (Address address : person.getAddresses()) {
                	assertNotNull("Address is null.", address);

                	assertEquals("Address id should be '" + addressId + "'.", addressId, address.getId());
                	assertEquals("Address address should be '" + address + "'.", addr, address.getAddress());
                }
            }

         // 두번째 person 테스트
            if (secondId.equals(person.getId())) {
                String name = "kim";

                int expectedAddresses = 2;

            	assertEquals("Person name should be " + name + ".", name, person.getName());

                assertNotNull("Person's address list is null.", person.getAddresses());
                assertEquals("Number of person's address list should be " + expectedAddresses + ".", expectedAddresses, person.getAddresses().size());

                Integer addressId = new Integer(3);
                String addr = "yokohama";

                for (Address address : person.getAddresses()) {
                	assertNotNull("Address is null.", address);

                	if (addressId.equals(address.getId())) {
	                	assertEquals("Address id should be '" + addressId + "'.", addressId, address.getId());
	                	assertEquals("Address address should be '" + address + "'.", addr, address.getAddress());
                	}
                }
            }
            logger.debug(person.toString());
        }
    }
}
