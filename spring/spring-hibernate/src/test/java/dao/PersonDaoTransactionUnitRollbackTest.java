package dao;

import java.sql.SQLException;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.test.annotation.Rollback;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.transaction.AfterTransaction;
import org.springframework.test.context.transaction.TransactionConfiguration;
import org.springframework.transaction.annotation.Transactional;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:shared-context.xml", "classpath:PersonDaoTest-context.xml"})
@TransactionConfiguration
@Transactional
public class PersonDaoTransactionUnitRollbackTest extends PersonDaoTransactionUnitTest {

    final Logger logger = LoggerFactory.getLogger(PersonDaoTransactionUnitRollbackTest.class);

    @Test
    @Rollback(false)
    public void testHibernateTemplate() throws SQLException {
        super.testHibernateTemplate();
    }

    /**
     * Tests that the size and first record match what is expected
     * after the transaction.
     */
    @AfterTransaction
    public void afterTransaction() {
        testPerson(false, CHANGED_NAME);
    }

}
