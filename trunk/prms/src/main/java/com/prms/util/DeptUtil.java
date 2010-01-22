package com.prms.util;

import java.io.IOException;
import java.io.Reader;
import java.sql.SQLException;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.ibatis.common.resources.Resources;
import com.ibatis.sqlmap.client.SqlMapClient;
import com.ibatis.sqlmap.client.SqlMapClientBuilder;
import com.prms.Constants;
import com.prms.exception.PrmsException;
import com.prms.model.Dept;

public class DeptUtil {

	private final static Logger logger = LoggerFactory.getLogger(DeptUtil.class);

	private DeptUtil() {
	}

	/**
	 * 会社コードに対して、最新の部署情報を全て取得する。
	 *
	 * @param comCode : 会社コード
	 * @return 部署情報リスト（level 1 : 上位部署、level 2 : 位部署）
	 * @throws SQLException
	 */
	public static List<Dept> getAllDept(String comCode) throws SQLException {

		Reader reader = null;
		List<Dept> list = null;

		try {
			reader = Resources
					.getResourceAsReader(Constants.SQL_MAP_CONFIG_FILE);
			SqlMapClient sqlMap = SqlMapClientBuilder.buildSqlMapClient(reader);
			list = sqlMap.queryForList("DeptUtil.getAllDept", comCode);
		} catch (IOException e) {
			logger.error(e.toString());
			throw new PrmsException(e);
		} finally {
			try {
				reader.close();
			} catch (IOException e) {
				logger.error(e.toString());
				throw new PrmsException(e);
			}
		}

		return list;
	}

	/**
	 * 会社コード、部署コードに対して、最新の上位部署情報を取得する。
	 *
	 * @param comCode : 会社コード
	 * @param deptCode : 部署コード
	 * @return 上位部署情報リスト
	 */
	public static List<Dept> getUpperDept(String comCode, String deptCode)
			throws SQLException {

		List<Dept> list = null;

		Reader reader = null;

		Dept dept = new Dept();
		dept.setComCode(comCode);
		dept.setDeptCode(deptCode);


		try {
			reader = Resources
					.getResourceAsReader(Constants.SQL_MAP_CONFIG_FILE);
			SqlMapClient sqlMap = SqlMapClientBuilder.buildSqlMapClient(reader);
			list = sqlMap.queryForList("DeptUtil.getUpperDept", dept);
		} catch (IOException e) {
			logger.error(e.toString());
			throw new PrmsException(e);
		} finally {
			try {
				reader.close();
			} catch (IOException e) {
				logger.error(e.toString());
				throw new PrmsException(e);
			}
		}

		return list;
	}

	/**
	 * 会社コード、部署コードに対して、最新の下位部署情報を取得する。
	 *
	 * @param comCode : 会社コード
	 * @param deptCode : 部署コード
	 * @return 下位部署情報
	 * @throws SQLException
	 */
	public static List<Dept> getSubDept(String comCode, String deptCode) throws SQLException {

		List<Dept> list = null;

		Reader reader = null;

		Dept dept = new Dept();
		dept.setComCode(comCode);
		dept.setDeptCode(deptCode);


		try {
			reader = Resources
					.getResourceAsReader(Constants.SQL_MAP_CONFIG_FILE);
			SqlMapClient sqlMap = SqlMapClientBuilder.buildSqlMapClient(reader);
			list = sqlMap.queryForList("DeptUtil.getSubDept", dept);
		} catch (IOException e) {
			logger.error(e.toString());
			throw new PrmsException(e);
		} finally {
			try {
				reader.close();
			} catch (IOException e) {
				logger.error(e.toString());
				throw new PrmsException(e);
			}
		}

		return list;
	}

}
