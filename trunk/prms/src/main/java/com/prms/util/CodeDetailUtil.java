package com.prms.util;

import java.io.IOException;
import java.io.Reader;
import java.sql.SQLException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.ibatis.common.resources.Resources;
import com.ibatis.sqlmap.client.SqlMapClient;
import com.ibatis.sqlmap.client.SqlMapClientBuilder;
import com.prms.Constants;
import com.prms.exception.PrmsException;
import com.prms.model.CodeDetail;

public class CodeDetailUtil {

	private final static Logger logger = LoggerFactory.getLogger(CodeDetailUtil.class);

	private CodeDetailUtil(){
		// do not instantiate
	}

	public static String getCodeDetailName(String codeType, String codeDetail) throws SQLException{

		Reader reader = null;
		String codeDetailName = null;

		CodeDetail bean = new CodeDetail(codeType, codeDetail);

		try {
			reader = Resources.getResourceAsReader(Constants.SQL_MAP_CONFIG_FILE);
			SqlMapClient sqlMap = SqlMapClientBuilder.buildSqlMapClient(reader);
			codeDetailName = (String) sqlMap.queryForObject("CodeDetailUtil.getCodeDetailNameByPk", bean);
		} catch (IOException e) {
			logger.error(e.toString());
			throw new PrmsException(e);
		}finally{
			try {
				reader.close();
			} catch (IOException e) {
				logger.error(e.toString());
				throw new PrmsException(e);
			}
		}
		return codeDetailName;
	}
}
