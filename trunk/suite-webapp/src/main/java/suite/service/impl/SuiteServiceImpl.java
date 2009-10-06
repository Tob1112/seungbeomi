package suite.service.impl;

import suite.dao.ibatis.SuiteDao;
import suite.service.SuiteService;
import suite.vo.User;

public class SuiteServiceImpl implements SuiteService{

	private SuiteDao suiteDao;

	public void setSuiteDao(SuiteDao suiteDao) {
		this.suiteDao = suiteDao;
	}

	public User login(String userId, String password) {
		User user = new User();
		user = suiteDao.login(userId, password);
		System.out.println(user);
		return user;
	}

}
