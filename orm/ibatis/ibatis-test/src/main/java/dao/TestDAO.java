package dao;

import static org.junit.Assert.*;

import java.io.IOException;
import java.io.Reader;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import org.apache.log4j.Logger;
import org.junit.Before;
import org.junit.Test;

import com.ibatis.common.resources.Resources;
import com.ibatis.sqlmap.client.SqlMapClient;
import com.ibatis.sqlmap.client.SqlMapClientBuilder;

import domain.Dept;
import domain.Emp;

public class TestDAO {

	static Logger logger = Logger.getLogger(TestDAO.class);

	private static final String SQL_MAP_CONFIG_FILE = "SqlMapConfig.xml";
	private Reader reader;
	private SqlMapClient sqlMap;

	@Before
	public void setUp(){
		try {
			reader = Resources.getResourceAsReader(SQL_MAP_CONFIG_FILE);
			sqlMap = SqlMapClientBuilder.buildSqlMapClient(reader);
		} catch (IOException e) {
			fail("初期化失敗");
		}
	}
/*
	@Test
	public void testJoin() {
		assertNotNull(reader);
		assertNotNull(sqlMap);

		try {

			Dept dept = (Dept) sqlMap.queryForObject("Dept.getDept", "D001");
			System.out.println("<<< " + dept);
			for(Emp emp: dept.getEmpList()) {
				System.out.println("<<< " + emp);
			}
		} catch (Exception e) {
			fail();
		}
	}
*/
	@SuppressWarnings("unchecked")
	@Test
	public void testResultHashMap(){
		Map<String, Object> parameters;
		Map<String, Object> results;

		parameters = new HashMap<String, Object>();
		parameters.put("DEPT_NO", "D001");

		try {
			//args
			// String id
			// Object parameter
			// String key	カラム名など
			results =  sqlMap.queryForMap("Emp.getEmpsByDeptNo", parameters, "EMP_NAME");
			System.out.println(results);
			assertEquals(2, results.size());
		} catch (SQLException e) {
			e.printStackTrace();
			fail();
		}

	}
}