package com.prms.util;

import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.prms.exception.PrmsException;
import com.prms.model.Message;

/**
 * 計算機クラス
 *
 * @author 孫承範
 * @author
 */
public class Calculator {

	private final static Logger logger = LoggerFactory.getLogger(Calculator.class);

	/**
	 * 時間の差を計算するメソッド
	 *
	 * @param fromTime 開始時間
	 * @param toTime 終了時間
	 * @return string 終了時間 - 開始時間
	 * @author 孫承範
	 */
	public static String diffTimeToString(String fromTime, String toTime) {

		Date fromDate = null;
		Date toDate = null;
		String result = "";

		if (fromTime == null || fromTime == "" || toTime == null || toTime == "") {
			return result;
		}

		try {
			fromDate = new SimpleDateFormat("HHmm").parse(fromTime);
			toDate = new SimpleDateFormat("HHmm").parse(toTime);
		} catch (ParseException e) {
			//logger.error(e.toString());
			e.printStackTrace();
			Message message = MessageUtil.getMessage("E", "0001");
			throw new PrmsException(message.getMsgBody(), e);
		}

		long diffSec = (toDate.getTime() - fromDate.getTime())/1000;

		double diffHour = diffSec/3600;
		double diffMin = (diffSec%3600)/60;
		result = Double.toString(diffHour + diffMin/60);

		//TODO 点桁２まで
		return result;
	}

	public static BigDecimal diffTimeToBigDecimal(String fromTime, String toTime) {
		BigDecimal result = new BigDecimal(0);
		if (fromTime == null || fromTime == "" || toTime == null || toTime == "") {
			return result;
		} else {
			String diffTimeToStringResult = diffTimeToString(fromTime, toTime);
			result = BigDecimal.valueOf(Double.valueOf(diffTimeToStringResult)).setScale(2, BigDecimal.ROUND_HALF_UP);
		}
		return result;
	}

}
