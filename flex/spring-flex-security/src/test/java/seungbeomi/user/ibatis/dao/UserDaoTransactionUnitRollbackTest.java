package seungbeomi.user.ibatis.dao;

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
@ContextConfiguration
@TransactionConfiguration
@Transactional
public class UserDaoTransactionUnitRollbackTest extends UserDaoTransactionUnitTest {

    final Logger logger = LoggerFactory.getLogger(UserDaoTransactionUnitRollbackTest.class);

    @Test
    @Rollback(false)
    public void testUserDaoTransactionUnit() throws Exception {
        super.testUserDaoTransactionUnit();
    }

    /**
     * Tests that the size and first record match what is expected
     * after the transaction.
     */
    @AfterTransaction
    public void afterTransaction() {
        testUser(false, CHANGED_NAME);
    }

}
