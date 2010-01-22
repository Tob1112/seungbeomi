package com.prms.util;

import java.io.IOException;
import java.io.Reader;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.ibatis.common.resources.Resources;
import com.ibatis.sqlmap.client.SqlMapClient;
import com.ibatis.sqlmap.client.SqlMapClientBuilder;
import com.prms.Constants;
import com.prms.exception.PrmsException;
import com.prms.model.Message;

public class MessageUtil {

	private final static Logger logger = LoggerFactory.getLogger(MessageUtil.class);

	private static final String MSG_NOT_FOUND = "予期せぬエラーが発生しました。";

	private MessageUtil() {
		// do not instantiate
	}

	public static Message getMessage(String msgType, String msgId){

		String msgNotFound  = MSG_NOT_FOUND;

		Reader reader = null;
		Message bean = new Message(msgType, msgId);

		try {
			reader = Resources
					.getResourceAsReader(Constants.SQL_MAP_CONFIG_FILE);
			SqlMapClient sqlMap = SqlMapClientBuilder.buildSqlMapClient(reader);
			String msgBody = (String) sqlMap.queryForObject("MessageUtil.getMessageByPk", bean);
			if (msgBody != null) {
				bean.setMsgBody(msgBody);
			} else {
				bean.setMsgBody(msgNotFound);
			}
		} catch (Exception e) {
			logger.error(e.toString());
			throw new PrmsException(e);
		} finally {
			try {
				reader.close();
			} catch (IOException e) {
				logger.error(e.toString());
				throw new PrmsException(e);
			}
		} // end try_finally

		return bean;
	}
}
