package test;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

public class TestDaoImpl extends SqlMapClientDaoSupport implements TestDao{

	private static final String SQL_INSERT = "user.insertTest";
	private static final String SQL_SELECT = "user.selectTest";
	
	public String sayHello() {
		return "Hello";
	}

	@Override
	public void insert(int id) {
		
		User user = new User();
		user.setUserId("userId" + id);
		user.setName("name" + id);
		user.setContents("contents" + id);
		
		getSqlMapClientTemplate().insert(SQL_INSERT, user);
	}

	@Override
	public User select(int id) {
		
		return (User) getSqlMapClientTemplate().queryForObject(SQL_SELECT, "userId" + id);
		
	}

}