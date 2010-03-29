package seungbeomi.user.ibatis.dao;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

import java.util.Collection;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import seungbeomi.user.model.User;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration
public class UserDaoTransactionTest{

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
		cleanInsertFlatXmlData("src/test/java/seungbeomi/user/ibatis/dao/testdata.xml");
    }

    @After
    public void tearDown() throws SQLException {
    	recovery();
    }
*/
    @Test
    public void testUserDaoTransaction() {
        assertNotNull("Person DAO is null.", userDao);

        Collection<User> userList = userDao.getUsers();

        assertNotNull("User list is null.", userList);
        assertEquals("Number of users should be " + SIZE + ".", SIZE, userList.size());

        for (User user : userList) {
            assertNotNull("Person is null.", user);

            if (USERID.equals(user.getUserId())) {
                assertEquals("User name should be " + NAME + ".", NAME, user.getName());

                user.setName(CHANGED_NAME);

                userDao.update(user);
            }
        }
    }
}
