package com.leinbow.dao;

import static org.junit.Assert.assertEquals;

import java.io.IOException;
import java.io.Reader;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.apache.ibatis.session.TransactionIsolationLevel;
import org.junit.Before;
import org.junit.Test;

import com.leinbow.domain.User;


public class UserMapperTest {

	private static String MYBATIS_CONFIG_NAME = "test-mybatis-config.xml";
	private Reader reader;
	private SqlSessionFactory sqlMapper;

	@Before
	public void setUp() throws IOException {
		reader = Resources.getResourceAsReader(MYBATIS_CONFIG_NAME);
		sqlMapper = new SqlSessionFactoryBuilder().build(reader);
	}

	@Test
	public void testCrudUser() {
		SqlSession session = sqlMapper.openSession(TransactionIsolationLevel.SERIALIZABLE);
		try {
			// list
			List<User> list = session.selectList("user.list");
			assertEquals(2, list.size());

			Map<String, Object> parameters = new HashMap<String, Object>();
			parameters.put("id", 1);

			// get
			User user = (User) session.selectOne("user.get", parameters);
			assertEquals("SON", user.getName());

			// insert
			parameters.clear();
			parameters.put("id", 3);
			parameters.put("name", "leinbow");

			session.insert("user.insert", parameters);
			list = session.selectList("user.list");
			assertEquals(3, list.size());

			// update
			parameters.clear();
			parameters.put("id", 3);
			parameters.put("name", "spring");

			session.update("user.update", parameters);

			user = (User) session.selectOne("get", parameters);
			assertEquals("spring", user.getName());

			// delete
			session.delete("user.delete", parameters);

			list = session.selectList("user.list");
			assertEquals(2, list.size());

		} finally {
			session.close();
		}
	}

}
