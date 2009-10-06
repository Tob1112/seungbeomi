package suite.dao.ibatis;

import suite.vo.User;

public interface SuiteDao {

	public User login(String userId, String password);

}
