package suite.dao.ibatis.impl;

import static org.junit.Assert.*;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import suite.dao.ibatis.SuiteDao;
import suite.vo.User;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:applicationContext-persist.xml"})
public class SuiteDaoImplTest {

	@Autowired
	private SuiteDao dao;

	@Test
	public void TestLogin() {
		String userId = "son";
		String password = "son";

		User user = dao.login(userId, password);
		System.out.println(user);
		assertEquals("son",user.getUserId());
	}
}
