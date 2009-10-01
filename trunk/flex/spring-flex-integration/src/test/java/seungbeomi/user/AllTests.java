package seungbeomi.user;

import org.junit.runner.RunWith;
import org.junit.runners.Suite;

@RunWith(Suite.class)
@Suite.SuiteClasses({
	UserDaoImplTest.class,
	UserServiceImplTest.class
})
public class AllTests {
}
