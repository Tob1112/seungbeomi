package com.prms.util;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.prms.exception.PrmsException;
import com.prms.model.FixTime;
import com.prms.model.Message;
import com.prms.model.TimesheetDetail;
import com.prms.model.ValidatorResult;

/**
 * 妥当性検証クラス
 *
 * @author 孫承範
 * @author
 */
public class Validator {

	private final static Logger logger = LoggerFactory.getLogger(Validator.class);

	// 正規表現パータン
	private static final String IS_NUMBER_PATTERN = "[^0-9]";
	private static final String IS_ENGLISH_PATTERN = "[^a-zA-Z]";
	private static final String IS_ENGLISH_AND_NUMBER_PATTERN = "[^a-zA-Z0-9]";

	private Validator() {
		// do not instantiate
	}

	/**
	 * 定時情報入力チェック
	 *
	 * @param list
	 *            定時情報ドメイン
	 * @return エラーであればtrueを返却
	 * @author 久場
	 */
	public static ValidatorResult isRequiredFixTime(List<FixTime> list) {

		logger.debug(" * start isRequiredFixTime");

		int fixTimeEmptyCount = 0;

		for (FixTime bean : list) {

			// 定時名称のNullチェック
			if (isEmpty(bean.getFixTimeName())) {
//				logger.debug(" * 定時名称が不正な値");
				//return new ValidatorResult("E", "0020", "");
				Message message = MessageUtil.getMessage("E", "0020");
				throw new PrmsException(message.getMsgBody());
			}

			logger.debug(" * 提示情報名称 : " + bean.getFixTimeName() + " **********************");
			logger.debug(" * 提示情報名称 : " + bean.toString());

			// 顧客名・時間単位・定時開始・定時終了フラグ trueの場合は全て入力されている
			boolean isInput = false;
			// お昼休み入力フラグ trueの場合はお昼休みが入力されている
			boolean lunchTimeFlag = false;

			// 定時名称の値チェック
			if (!isFixTimeName(bean.getFixTimeName())) {
//				logger.debug(" * 定時名称が不正な値");
				//return new ValidatorResult("E", "0020", bean.getFixTimeName());
				Message message = MessageUtil.getMessage("E", "0020");
				throw new PrmsException(message.getMsgBody() + " - " + bean.getFixTimeName());
			}

			// trim処理
			if (bean.getClientName() != null) {
				bean.setClientName(bean.getClientName().trim());
			}
			// if (bean.getFixTimeName() != null) {
			// bean.setFixTimeName(bean.getFixTimeName().trim());
			// }
			if (bean.getWorkStartTime() != null) {
				bean.setWorkStartTime(bean.getWorkStartTime().trim());
			}
			if (bean.getWorkEndTime() != null) {
				bean.setWorkEndTime(bean.getWorkEndTime().trim());
			}
			if (bean.getLunchStartTime() != null) {
				bean.setLunchStartTime(bean.getLunchStartTime().trim());
			}
			if (bean.getLunchEndTime() != null) {
				bean.setLunchEndTime(bean.getLunchEndTime().trim());
			}

			// 顧客名・時間単位・定時開始・定時終了が全て入力されている場合
			if (!isEmpty(bean.getClientName()) && bean.getTimeUnit() != null
					&& !isEmpty(bean.getWorkStartTime())
					&& !isEmpty(bean.getWorkEndTime())) {
				isInput = true;
			}
			// 顧客名・時間単位・定時開始・定時終了が全て入力されていない場合
			if (isInput == false) {
				if (isEmpty(bean.getClientName()) && bean.getTimeUnit() == null
						&& isEmpty(bean.getWorkStartTime())
						&& isEmpty(bean.getWorkEndTime())) {
					// お昼休みだけが入力されていた場合
					if (!isEmpty(bean.getLunchStartTime())
							|| !isEmpty(bean.getLunchEndTime())) {
//						logger.debug(" * お昼休みだけが入力されている");
						//return new ValidatorResult("E", "0021", bean.getFixTimeName());
						Message message = MessageUtil.getMessage("E", "0021");
						throw new PrmsException(message.getMsgBody() + " - " + bean.getFixTimeName());
					}
				} else {
//					logger.debug(" * 顧客名・時間単位・定時開始・定時終了の入力が不完全");
					//return new ValidatorResult("E", "0022", bean.getFixTimeName());
					Message message = MessageUtil.getMessage("E", "0022");
					throw new PrmsException(message.getMsgBody() + " - " + bean.getFixTimeName());
				}
				// 入力無し定時情報をカウント
				fixTimeEmptyCount++;
			}

			// 顧客名・時間単位・定時開始・定時終了フラグ が全て入力されている場合
			if (isInput) {

				// お昼休みペアチェック
				if (!isEmpty(bean.getLunchStartTime())
						&& !isEmpty(bean.getLunchEndTime())) {
					// 両方入力されている
					lunchTimeFlag = true;
				} else if (isEmpty(bean.getLunchStartTime())
						&& isEmpty(bean.getLunchEndTime())) {
					// 両方入力されていない
					lunchTimeFlag = false;
				} else {
//					logger.debug(" * お昼休みの入力が不完全");
					//return new ValidatorResult("E", "0023", bean.getFixTimeName());
					Message message = MessageUtil.getMessage("E", "0023");
					throw new PrmsException(message.getMsgBody() + " - " + bean.getFixTimeName());
				}

				// お昼休みチェック
				if (lunchTimeFlag) {
					// 数字チェック
					if (!isNumber(bean.getLunchStartTime())
							|| !isNumber(bean.getLunchEndTime())) {
//						logger.debug(" * お昼休み開始・お昼休み終了に数字以外が含まれている");
						//return new ValidatorResult("E", "0024", bean.getFixTimeName());
						Message message = MessageUtil.getMessage("E", "0024");
						throw new PrmsException(message.getMsgBody() + " - " + bean.getFixTimeName());
					}
					// 桁数チェック
					if (!isLengthOfCharacter(bean.getLunchStartTime(), 4)
							|| !isLengthOfCharacter(bean.getLunchEndTime(), 4)) {
//						logger.debug(" * お昼休み開始・お昼休み終了の桁数が不正");
						//return new ValidatorResult("E", "0025", bean.getFixTimeName());
						Message message = MessageUtil.getMessage("E", "0025");
						throw new PrmsException(message.getMsgBody() + " - " + bean.getFixTimeName());
					}
				}

				// 数字チェック
				if (!isNumber(bean.getWorkStartTime())
						|| !isNumber(bean.getWorkEndTime())) {
//					logger.debug(" * 定時開始・定時終了に数字以外が含まれている");
					//return new ValidatorResult("E", "0026", bean.getFixTimeName());
					Message message = MessageUtil.getMessage("E", "0026");
					throw new PrmsException(message.getMsgBody() + " - " + bean.getFixTimeName());
				}

				// 桁数チェック
				if (!isLengthOfCharacter(bean.getWorkStartTime(), 4)
						|| !isLengthOfCharacter(bean.getWorkEndTime(), 4)) {
//					logger.debug(" * 定時開始・定時終了の桁数が不正");
					//return new ValidatorResult("E", "0027", bean.getFixTimeName());
					Message message = MessageUtil.getMessage("E", "0027");
					throw new PrmsException(message.getMsgBody() + " - " + bean.getFixTimeName());
				}

				// 時間整合性チェック　お昼休み含む
				if (lunchTimeFlag) {
					if (!isInRangeFixTime(bean.getWorkStartTime(), bean
							.getWorkEndTime(), bean.getLunchStartTime(), bean
							.getLunchEndTime())) {
//						logger.debug(" * 開始時間、終了時間、お昼休み時間の整合性不正");
						//return new ValidatorResult("E", "0028", bean.getFixTimeName());
						Message message = MessageUtil.getMessage("E", "0028");
						throw new PrmsException(message.getMsgBody() + " - " + bean.getFixTimeName());
					}
					// 時間範囲チェック　お昼休みを含まない
				} else {
					int _workStartTime = Integer.parseInt(bean
							.getWorkStartTime());
					int _workEndTime = Integer.parseInt(bean.getWorkEndTime());
					// 開始 >= 終了
					if (_workStartTime >= _workEndTime) {
//						logger.debug(" * 開始時間、終了時間の整合性不正");
						//return new ValidatorResult("E", "0029", bean.getFixTimeName());
						Message message = MessageUtil.getMessage("E", "0029");
						throw new PrmsException(message.getMsgBody() + " - " + bean.getFixTimeName());
					}
				}

				// 顧客名長さチェック
				if (!isByteLengthOfOverCharacter(bean.getClientName(), 64)) {
//					logger.debug(" * 顧客名長さ不正");
					//return new ValidatorResult("E", "0030", bean.getFixTimeName());
					Message message = MessageUtil.getMessage("E", "0030");
					throw new PrmsException(message.getMsgBody() + " - " + bean.getFixTimeName());
				}

				// 時間単位のチェック
				if (bean.getTimeUnit().doubleValue() != 0) {
					// ０以下　少数チェック
					if (bean.getTimeUnit().doubleValue() < 0
							|| bean.getTimeUnit().doubleValue() != bean
									.getTimeUnit().intValue()) {
//						logger.debug(" * 時間単位にマイナス又は少数が含まれている");
						//return new ValidatorResult("E", "0031", bean.getFixTimeName());
						Message message = MessageUtil.getMessage("E", "0031");
						throw new PrmsException(message.getMsgBody() + " - " + bean.getFixTimeName());
					}
					// 数字範囲チェック
					if (!isScopeOfNumber(Integer.toString(bean.getTimeUnit()
							.intValue()), 1, 60)) {
//						logger.debug(" * 時間単位が１～６０では無い");
						//return new ValidatorResult("E", "0032", bean.getFixTimeName());
						Message message = MessageUtil.getMessage("E", "0032");
						throw new PrmsException(message.getMsgBody() + " - " + bean.getFixTimeName());
					}
				}
			}
		}

		// 全てのレコードが入力されていない場合はエラー
		ArrayList array = (ArrayList) list;
		if (fixTimeEmptyCount == array.size()) {
//			logger.debug(" * 定時情報が一つも入力されていない");
			//return new ValidatorResult("E", "0033", "");
			Message message = MessageUtil.getMessage("E", "0033");
			throw new PrmsException(message.getMsgBody());
		}

		logger.debug(" * end isRequiredFixTime");

		return null;
	}

	/**
	 * 定時情報時間整合性チェック
	 *
	 * @param workStartTime
	 *            始業時間
	 * @param workEndTime
	 *            終業時間
	 * @param lunchStartTime
	 *            お昼休み開始時間
	 * @param lunchEndTime
	 *            お昼休み終了時間
	 * @return 正常終了の場合true
	 * @author 久場
	 */
	public static boolean isInRangeFixTime(String workStartTime,
			String workEndTime, String lunchStartTime, String lunchEndTime) {

		// 時間に変換
		int _workStartTime = Integer.parseInt(workStartTime);
		int _workEndTime = Integer.parseInt(workEndTime);
		int _lunchStartTime = Integer.parseInt(lunchStartTime);
		int _lunchEndTime = Integer.parseInt(lunchEndTime);

		// 開始 >= 終了
		// お昼開始 >= お昼終了
		if (_workStartTime >= _workEndTime || _lunchStartTime >= _lunchEndTime) {
			return false;
		}

		// 開始 > お昼開始
		// 開始 > お昼終了
		// 終了 < お昼開始
		// 終了 < お昼終了
		if (_workStartTime > _lunchStartTime || _workStartTime > _lunchEndTime
				|| _workEndTime < _lunchStartTime
				|| _workEndTime < _lunchEndTime) {
			return false;
		}

		return true;
	}

	/**
	 * 定時名称値チェック
	 *
	 * @param fixTimeName
	 *            定時名称
	 * @return 定時名称として正しい値であればtrue
	 * @author 久場
	 */
	public static boolean isFixTimeName(String fixTimeName) {
		// 定時名称チェック
		if (fixTimeName.equals("A") || fixTimeName.equals("B")
				|| fixTimeName.equals("C")) {
		} else {
			return false;
		}
		return true;
	}

	/**
	 * 勤務表（日）入力チェック
	 *
	 * @param list
	 *            勤務表（日）ドメイン
	 * @return エラーであればtrueを返却
	 * @author 久場
	 */
	public static ValidatorResult isRequiredTimesheetDetail(List<TimesheetDetail> list) {

		logger.debug(" * start isRequiredTimesheetDetail");

		for (TimesheetDetail bean : list) {

			// 日付がnull
			if (bean.getYyyymmdd() == null) {
//				logger.debug(" * 日付がnull");
				//return new ValidatorResult("E", "0050", "");
				Message message = MessageUtil.getMessage("E", "0050");
				throw new PrmsException(message.getMsgBody());
			}

			if (logger.isDebugEnabled()) {
				logger.debug(" * TimeSheetDetail : " + bean.getYyyymmdd() + " - " + bean.toString());
			}

			// 出勤フラグ trueであれば出勤
			boolean isWorkFlg = false;
			// その他フラグ trueであればその他
			boolean isEtcFlag = false;

			// 勤務形態チェック
			if (!isEmpty(bean.getWorkPatternCode())) {

				// trim処理
				if (bean.getWorkPatternCode() != null) {
					bean.setWorkPatternCode(bean.getWorkPatternCode().trim());
				}
				// if (bean.getFixTimeName() != null) {
				// bean.setFixTimeName(bean.getFixTimeName().trim());
				// }
				if (bean.getWorkStartTime() != null) {
					bean.setWorkStartTime(bean.getWorkStartTime().trim());
				}
				if (bean.getWorkEndTime() != null) {
					bean.setWorkEndTime(bean.getWorkEndTime().trim());
				}

				// 勤務形態が　公休、有給、代休、特別休暇、欠勤
				if (bean.getWorkPatternCode().equals("02")
						|| bean.getWorkPatternCode().equals("05")
						|| bean.getWorkPatternCode().equals("08")
						|| bean.getWorkPatternCode().equals("09")
						|| bean.getWorkPatternCode().equals("10")) {
					// 時間が一つでも入力されていたら
					if (!isEmpty(bean.getFixTimeName())
							|| !isEmpty(bean.getWorkStartTime())
							|| !isEmpty(bean.getWorkEndTime())
							|| bean.getBreakTimeTotal() != null
							|| bean.getActualTime() != null) {
//						logger.debug(" * 勤務形態は休み系だが、値が入力されている");
						//return new ValidatorResult("E", "0051", bean.getYyyymmdd().toString());
						Message message = MessageUtil.getMessage("E", "0051");
						throw new PrmsException(message.getMsgBody() + " - " + bean.getYyyymmdd().toString());
					}
//					logger.debug(" * 勤務形態が休み系");
					isWorkFlg = false;

					// 勤務形態が　通常勤務、午前休、午後休、休出、休出(代休)
				} else if (bean.getWorkPatternCode().equals("01")
						|| bean.getWorkPatternCode().equals("03")
						|| bean.getWorkPatternCode().equals("04")
						|| bean.getWorkPatternCode().equals("06")
						|| bean.getWorkPatternCode().equals("07")) {
					// 時間が一つでも入力されていなかったら
					if (isEmpty(bean.getFixTimeName())
							|| isEmpty(bean.getWorkStartTime())
							|| isEmpty(bean.getWorkEndTime())
//							|| bean.getBreakTimeTotal() == null
							|| bean.getActualTime() == null) {
//						logger.debug(" * 勤務形態が出勤系だが、その他が入力されていない");
						//return new ValidatorResult("E", "0052", bean.getYyyymmdd().toString());
						Message message = MessageUtil.getMessage("E", "0052");
						throw new PrmsException(message.getMsgBody() + " - " + bean.getYyyymmdd().toString());
					}
//					logger.debug(" * 勤務形態が出勤系");
					isWorkFlg = true;

				} else if (bean.getWorkPatternCode().equals("11")) {
					// 勤務形態が　その他
//					logger.debug(" * 勤務形態がその他");
					isEtcFlag = true;

				} else {
					// 勤務形態が　不明
//					logger.debug(" * 勤務形態が認識できない値");
					//return new ValidatorResult("E", "0053", bean.getYyyymmdd().toString());
					Message message = MessageUtil.getMessage("E", "0053");
					throw new PrmsException(message.getMsgBody() + " - " + bean.getYyyymmdd().toString());
				}
			} else {
//				logger.debug(" * 勤務形態が入力されていない");
				//return new ValidatorResult("E", "0054", bean.getYyyymmdd().toString());
				Message message = MessageUtil.getMessage("E", "0054");
				throw new PrmsException(message.getMsgBody() + " - " + bean.getYyyymmdd().toString());
			}

			// 備考チェック
			if (!isEmpty(bean.getNote())) {
				// 文字数
				if (!isByteLengthOfOverCharacter(bean.getNote(), 512)) {
//					logger.debug(" * 備考が512文字を超えている");
					//return new ValidatorResult("E", "0055", bean.getYyyymmdd().toString());
					Message message = MessageUtil.getMessage("E", "0055");
					throw new PrmsException(message.getMsgBody() + " - " + bean.getYyyymmdd().toString());
				}
			}

			// 勤務形態が　その他
			if (isEtcFlag) {

				if (!isFixTimeName(bean.getFixTimeName())) {
//					logger.debug(" * 定時名称が不正な値");
					//return new ValidatorResult("E", "0056", bean.getYyyymmdd().toString());
					Message message = MessageUtil.getMessage("E", "0056");
					throw new PrmsException(message.getMsgBody() + " - " + bean.getYyyymmdd().toString());
				}
				// 開始時間
				if (!isEmpty(bean.getWorkStartTime())) {
					// 数字チェック
					if (!isNumber(bean.getWorkStartTime())) {
//						logger.debug(" * 開始時間に数字以外が含まれている");
						//return new ValidatorResult("E", "0057", bean.getYyyymmdd().toString());
						Message message = MessageUtil.getMessage("E", "0057");
						throw new PrmsException(message.getMsgBody() + " - " + bean.getYyyymmdd().toString());
					}
					// 桁数チェック
					if (!isLengthOfCharacter(bean.getWorkStartTime(), 4)) {
//						logger.debug(" * 開始時間の桁数が不正");
						//return new ValidatorResult("E", "0058", bean.getYyyymmdd().toString());
						Message message = MessageUtil.getMessage("E", "0058");
						throw new PrmsException(message.getMsgBody() + " - " + bean.getYyyymmdd().toString());
					}
				}
				// 終了時間
				if (!isEmpty(bean.getWorkEndTime())) {
					// 数字チェック
					if (!isNumber(bean.getWorkEndTime())) {
//						logger.debug(" * 終了時間に数字以外が含まれている");
						//return new ValidatorResult("E", "0059", bean.getYyyymmdd().toString());
						Message message = MessageUtil.getMessage("E", "0059");
						throw new PrmsException(message.getMsgBody() + " - " + bean.getYyyymmdd().toString());
					}
					// 桁数チェック
					if (!isLengthOfCharacter(bean.getWorkEndTime(), 4)) {
//						logger.debug(" * 終了時間の桁数が不正");
						//return new ValidatorResult("E", "0060", bean.getYyyymmdd().toString());
						Message message = MessageUtil.getMessage("E", "0060");
						throw new PrmsException(message.getMsgBody() + " - " + bean.getYyyymmdd().toString());
					}
				}
				// 休憩時間
				if (bean.getBreakTimeTotal() != null) {
					if (!isSmallNumberCharacter(bean.getBreakTimeTotal(), 3, 2)) {
//						logger.debug(" * 休憩時間の桁数が不正");
						//return new ValidatorResult("E", "0061", bean.getYyyymmdd().toString());
						Message message = MessageUtil.getMessage("E", "0061");
						throw new PrmsException(message.getMsgBody() + " - " + bean.getYyyymmdd().toString());
					}
				}
				// 実働時間
				if (!isSmallNumberCharacter(bean.getActualTime(), 3, 2)) {
//					logger.debug(" * 実働時間の桁数が不正");
					//return new ValidatorResult("E", "0062", bean.getYyyymmdd().toString());
					Message message = MessageUtil.getMessage("E", "0062");
					throw new PrmsException(message.getMsgBody() + " - " + bean.getYyyymmdd().toString());
				}

			} else {

				// 勤務形態が　出勤系
				if (isWorkFlg) {

					if (!isFixTimeName(bean.getFixTimeName())) {
//						logger.debug(" * 定時名称が不正な値");
						//return new ValidatorResult("E", "0063", bean.getYyyymmdd().toString());
						Message message = MessageUtil.getMessage("E", "0063");
						throw new PrmsException(message.getMsgBody() + " - " + bean.getYyyymmdd().toString());
					}
					// 数字チェック
					if (!isNumber(bean.getWorkStartTime())
							|| !isNumber(bean.getWorkEndTime())) {
//						logger.debug(" * 開始時間・終了時間に数字以外が含まれている");
						//return new ValidatorResult("E", "0064", bean.getYyyymmdd().toString());
						Message message = MessageUtil.getMessage("E", "0064");
						throw new PrmsException(message.getMsgBody() + " - " + bean.getYyyymmdd().toString());
					}
					// 桁数チェック
					if (!isLengthOfCharacter(bean.getWorkStartTime(), 4)
							|| !isLengthOfCharacter(bean.getWorkEndTime(), 4)) {
//						logger.debug(" * 開始時間・終了時間の桁数が不正");
						//return new ValidatorResult("E", "0065", bean.getYyyymmdd().toString());
						Message message = MessageUtil.getMessage("E", "0065");
						throw new PrmsException(message.getMsgBody() + " - " + bean.getYyyymmdd().toString());
					}
					// 休憩時間チェック
					if (bean.getBreakTimeTotal() != null) {
						if (!isSmallNumberCharacter(bean.getBreakTimeTotal(), 3, 2)) {
//							logger.debug(" * 休憩時間の桁数が不正");
							//return new ValidatorResult("E", "0066", bean.getYyyymmdd().toString());
							Message message = MessageUtil.getMessage("E", "0066");
							throw new PrmsException(message.getMsgBody() + " - " + bean.getYyyymmdd().toString());
						}
					}
					// 実働時間チェック
					if (!isSmallNumberCharacter(bean.getActualTime(), 3, 2)) {
//						logger.debug(" * 実働時間の桁数が不正");
						//return new ValidatorResult("E", "0067", bean.getYyyymmdd().toString());
						Message message = MessageUtil.getMessage("E", "0067");
						throw new PrmsException(message.getMsgBody() + " - " + bean.getYyyymmdd().toString());
					}
					// 時間整合性チェック
					if (!isInRangeTimesheetDetail(bean.getWorkStartTime(), bean
							.getWorkEndTime(), bean.getBreakTimeTotal(), bean
							.getActualTime())) {
//						logger.debug(" * 開始時間、終了時間、休憩時間、実働時間の整合性不正");
						//return new ValidatorResult("E", "0068", bean.getYyyymmdd().toString());
						Message message = MessageUtil.getMessage("E", "0068");
						throw new PrmsException(message.getMsgBody() + " - " + bean.getYyyymmdd().toString());
					}

				} else {
					// 勤務形態が　休み系
					// 処理なし
				}
			}
		}

		logger.debug(" * end isRequiredTimesheetDetail");

		return null;
	}

	/**
	 * 勤務表時間整合性チェック
	 *
	 * @param workStartTime
	 *            開始時間
	 * @param workEndTime
	 *            終了時間
	 * @param breakTimeTotal
	 *            休憩時間合計
	 * @param actualTime
	 *            実働時間
	 * @return 正常終了の場合true
	 * @author 久場
	 */
	public static boolean isInRangeTimesheetDetail(String workStartTime,
			String workEndTime, BigDecimal breakTimeTotal, BigDecimal actualTime) {

		int _workStartTime = Integer.parseInt(workStartTime);
		int _workEndTime = Integer.parseInt(workEndTime);

		// 開始 > 終了
		if (_workStartTime >= _workEndTime) {
			return false;
		}

		return true;
	}

	/**
	 * 空文字及びNULLチェック String型のみを扱う
	 *
	 * @param str
	 *            判定を行いたい文字列（String）
	 * @return 空文字及びNULLの場合true
	 * @author 久場
	 */
	public static boolean isEmpty(String str) {

		boolean rs = false;

		if (str == null || str.length() == 0) {
			rs = true;
		}

		return rs;
	}

	/**
	 * BigDecimal型 NULL、0チェック
	 *
	 * @param str
	 *            判定を行いたい文字列（bigDecimal）
	 * @return NULLまたは0の場合true
	 * @author 久場
	 */
	public static boolean isEmptyBigDecimal(BigDecimal bigDecimal) {

		boolean rs = false;

		if (bigDecimal == null || bigDecimal.equals(new BigDecimal(0))) {
			rs = true;
		}

		return rs;
	}

	// /**
	// * 空文字及びNULLチェック
	// *
	// * @param args
	// * @return true RuntimeException <br /> false 空文字及びNULL
	// * @exception RuntimeException
	// */
	// public static boolean isEmpty(Object ...args) {
	//
	// for (Object value : args) {
	// if (value == null) {
	// throw new RuntimeException("空文字及びNull妥当性検証例外発生");
	// } else if (value instanceof java.lang.String) {
	// String convertValue = (String) Converter.convert(String.class, value);
	// if (convertValue == null || convertValue.equals("") ||
	// convertValue.trim().length() == 0) {
	// throw new RuntimeException("空文字及びNull妥当性検証例外発生");
	// }
	// }
	// }
	// return false;
	// }

	// /**
	// * 桁数チェック
	// *
	// * @return
	// */
	// public static boolean validateCipher() {
	// return false;
	// }

	/**
	 * 半角数字チェック
	 *
	 * @param str
	 *            判定を行いたい文字列（半角数字）
	 * @return 半角数字の場合true
	 * @author 久場
	 */
	public static boolean isNumber(String str) {
		// nullチェック
		if (isEmpty(str)) {
			return false;
		}
		// matcherを作成
		Pattern p = Pattern.compile(IS_NUMBER_PATTERN);
		Matcher m = p.matcher(str);
		// 判定
		if (m.find()) {
			return false;
		}
		return true;
	}

	/**
	 * 半角英字チェック
	 *
	 * @param str
	 *            判定を行いたい文字列（半角英字）
	 * @return 半角英字の場合true
	 * @author 久場
	 */
	public static boolean isEnglish(String str) {
		// nullチェック
		if (isEmpty(str)) {
			return false;
		}
		// matcherを作成
		Pattern p = Pattern.compile(IS_ENGLISH_PATTERN);
		Matcher m = p.matcher(str);
		// 判定
		if (m.find() || str.equals("")) {
			return false;
		}
		return true;
	}

	/**
	 * 半角英数字チェック
	 *
	 * @param str
	 *            判定を行いたい文字列（半角英数字）
	 * @return 半角英数字の場合true
	 * @author 久場
	 */
	public static boolean isEnglishAndNumber(String str) {
		// nullチェック
		if (isEmpty(str)) {
			return false;
		}
		// matcherを作成
		Pattern p = Pattern.compile(IS_ENGLISH_AND_NUMBER_PATTERN);
		Matcher m = p.matcher(str);
		// 判定
		if (m.find() || str.equals("")) {
			return false;
		}
		return true;
	}

	/**
	 * 文字数チェック 文字数判定 全角も半角と同様にカウントする スペースもカウントする
	 *
	 * @param str
	 *            判定を行いたい文字列
	 * @param len
	 *            判定を行いたい数
	 * @return 文字数が指定された数字と同様であればtrue
	 * @author 久場
	 */
	public static boolean isLengthOfCharacter(String str, int len) {
		// nullチェック
		if (str == null) {
			return false;
		}
		// lengthを比較
		if (len != str.length()) {
			return false;
		}
		return true;
	}

	/**
	 * 文字数チェック 文字数判定 全角も半角と同様にカウントする
	 *
	 * @param str
	 *            判定を行いたい文字列
	 * @param len
	 *            判定を行いたい数
	 * @return 文字数が指定された数以内であればtrue
	 * @author 久場
	 */
	public static boolean isLengthOfOverCharacter(String str, int len) {
		// nullチェック
		if (str == null) {
			return false;
		}
		// lengthを比較
		if (len < str.length()) {
			return false;
		}
		return true;
	}

	/**
	 * 文字列バイト数チェック 文字数判定 全角も半角と同様にカウントする
	 *
	 * @param str
	 *            判定を行いたい文字列
	 * @param len
	 *            判定を行いたい数
	 * @return バイト数が指定された数以内であればtrue
	 * @author 久場
	 */
	public static boolean isByteLengthOfOverCharacter(String str, int len) {
		// nullチェック
		if (str == null) {
			return false;
		}
		// lengthを比較
		if (len < str.getBytes().length) {
			return false;
		}
		return true;
	}

	/**
	 * 半角少数桁数チェック （正数のみの判定は不可）
	 *
	 * @param bigDecimal
	 *            判定を行いたい値（半角少数）
	 * @param normalNumber
	 *            正数部の桁数（１以上）
	 * @param smallNumber
	 *            小数部の桁数（１以上）
	 * @return bigDecimal正数部、少数部の桁数が指定数より上ならtrue
	 * @author 久場
	 */
	public static boolean isSmallNumberCharacter(BigDecimal bigDecimal,
			int normalNumber, int smallNumber) {
		// nullチェック
		if (bigDecimal == null) {
			return false;
		}
		// 正数、少数が1より下
		if (normalNumber < 1 || smallNumber < 1) {
			return false;
		}
		// 正規表現パターンを作成
		String strNormal = Integer.toString(normalNumber);
		String strSmall = Integer.toString(smallNumber);
		String pattern = "^[0-9]{1," + strNormal + "}($|\\.[0-9]{1," + strSmall
				+ "}$)";
		// matcherを作成
		Pattern p = Pattern.compile(pattern);
		Matcher m = p.matcher(Double.toString(bigDecimal.doubleValue()));
		// 判定
		if (!m.find()) {
			return false;
		}
		return true;
	}

	/**
	 * 数字範囲チェック 文字列の値は○○～○○の間か判定 全角数字も半角数字と同様に扱う
	 *
	 * @param str
	 *            判定を行いたい文字列（数字）
	 * @param min
	 *            最小範囲
	 * @param max
	 *            最大範囲
	 * @return 文字列の値が指定された範囲内であればtrue 数字以外の文字が含まれていればfalse 空文字もfalse
	 *         minがmaxより大きい場合もfalse
	 * @author 久場
	 */
	public static boolean isScopeOfNumber(String str, int min, int max) {
		int number;
		// minがmaxより大きい場合は判定不能なので即終了
		if (min > max) {
			return false;
		}
		// nullチェック
		if (isEmpty(str)) {
			return false;
		}
		// 数字チェック
		if (!isNumber(str)) {
			return false;
		}
		// 文字を数字に変換
		number = Integer.parseInt(str);
		// 比較
		if (min > number || max < number) {
			return false;
		}
		return true;
	}

}
