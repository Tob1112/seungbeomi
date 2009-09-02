package seungbeomi.user.ibatis.dao;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

import java.util.ArrayList;
import java.util.Collection;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.transaction.AfterTransaction;
import org.springframework.test.context.transaction.BeforeTransaction;
import org.springframework.test.context.transaction.TransactionConfiguration;
import org.springframework.transaction.annotation.Transactional;

import seungbeomi.user.model.User;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration
@TransactionConfiguration
@Transactional
public class UserDaoTransactionUnitTest{

	private Logger logger = LoggerFactory.getLogger(getClass());

    protected static int SIZE = 2;
    protected static String USERID = "son";
    protected static String NAME = "seungbeomi";
    protected static String CHANGED_NAME = "springframework";

    @Autowired
    protected UserDao userDao = null;
/*
    @Before
    public void setUp() throws Exception {
		backup();
		//cleanInsertFlatXmlData("src/test/java/seungbeomi/user/ibatis/dao/testdata.xml");
    }

    @After
    public void tearDown() throws SQLException {
    	recovery();
    }
*/
    @BeforeTransaction
    public void beforeTransaction() {
        testUser(true, NAME);
    }

    @Test
    public void testUserDaoTransactionUnit() throws Exception {
        assertNotNull("User DAO is null.", userDao);

        Collection<User> userList = userDao.findUsers();

        assertNotNull("User list is null.", userList);
        assertEquals("Number of users should be " + SIZE + ".", SIZE, userList.size());

        for (User user : userList) {
            assertNotNull("User is null.", user);

            if (USERID.equals(user.getUserId())) {
                assertEquals("User name should be " + NAME + ".", NAME, user.getName());

                user.setName(CHANGED_NAME);

                userDao.update(user);
            }
        }
    }

    @AfterTransaction
    public void afterTransaction() {
        testUser(false, NAME);
    }

    protected void testUser(boolean beforeTransaction, String matchLastName) {
        ArrayList<User> userList = (ArrayList<User>) userDao.findUsers();

        assertNotNull("Person list is null.", userList);
        assertEquals("Number of users should be " + SIZE + ".", SIZE, userList.size());

        User user = userList.get(0);

        logger.debug((beforeTransaction ? "Before" : "After") + " transaction.  " + user.toString());

        String userId = user.getUserId();
        String name = user.getName();

        if (USERID.equals(userId)) {
            assertEquals("User name should be " + NAME + ".", NAME, name);
        }
    }

}
