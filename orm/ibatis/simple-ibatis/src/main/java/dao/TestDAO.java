package dao;

import java.io.Reader;

import org.apache.log4j.Logger;

import com.ibatis.common.resources.Resources;
import com.ibatis.sqlmap.client.SqlMapClient;
import com.ibatis.sqlmap.client.SqlMapClientBuilder;

import domain.Dept;
import domain.Emp;

public class TestDAO {

	static Logger logger = Logger.getLogger(TestDAO.class);

	public static void main(String[] args) {
		final String SQL_MAP_CONFIG_FILE = "SqlMapConfig.xml";
		try {
			Reader reader = Resources.getResourceAsReader(SQL_MAP_CONFIG_FILE);
			SqlMapClient sqlMap = SqlMapClientBuilder.buildSqlMapClient(reader);

			Dept dept = (Dept) sqlMap.queryForObject("Dept.getDept", "D001");
			System.out.println("    RESULT : " + dept);
			for(Emp emp: dept.getEmpList()) {
				System.out.println("    RESULT : " + emp);
			}
			/*
			Dept d = new Dept();
			d.setDeptNo("111");
			d.setDeptName("222");
			sqlMap.insert("Dept.addDept", d);
			*/
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}