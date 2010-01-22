package com.prms.service.impl;

import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.ListIterator;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.prms.Constants;
import com.prms.dao.TimesheetDao;
import com.prms.exception.PrmsException;
import com.prms.model.Account;
import com.prms.model.CodeDetail;
import com.prms.model.FixTime;
import com.prms.model.Message;
import com.prms.model.Timesheet;
import com.prms.model.TimesheetDetail;
import com.prms.model.ValidatorResult;
import com.prms.service.TimesheetService;
import com.prms.util.Calculator;
import com.prms.util.CodeDetailUtil;
import com.prms.util.MessageUtil;
import com.prms.util.Validator;

import flex.messaging.FlexContext;
import flex.messaging.FlexSession;

/**
 * 勤務表実装クラス
 *
 * @author 孫承範
 * @author
 */
public class TimesheetServiceImpl implements TimesheetService {

	private final Logger logger = LoggerFactory.getLogger(getClass());

	/** 勤務表DAO */
	private TimesheetDao timesheetDao;

	/** セッション */
	private FlexSession session;

	private Timesheet timesheet;

	/**
	 * 勤務表(月), 勤務表(日), 定時情報を取得
	 *
	 * @param bean
	 *            : 勤務表(月)
	 * @author
	 */
	public Timesheet getTimesheetAndChildByPk(Timesheet bean) {

		session = FlexContext.getFlexSession();
		Account account = (Account) session.getAttribute("account");

		setEmpNoAndComCode(bean, account.getEmpNo(), account.getComCode());
		Timesheet result = timesheetDao.getTimesheetAndChildByPk(bean);
		try {
			result.setCodeDetailName(CodeDetailUtil.getCodeDetailName(Constants.CODE_TYPE_STATUS, bean.getStatusCode()));
		} catch (SQLException e) {
			logger.error(e.toString());
			throw new PrmsException(e);
		}
		return result;
	}

	/**
	 * セッションから社員名取得
	 *
	 */
	public Timesheet getEmpNameBySession(){

		timesheet = new Timesheet();

		session = FlexContext.getFlexSession();

		Account account = (Account) session.getAttribute("account");

		timesheet.setLastName(account.getLastName());
		timesheet.setFirstName(account.getFirstName());
		timesheet.setEmpNo(account.getEmpNo());
		timesheet.setComCode(account.getComCode());

		return timesheet;
	}


	/**
	 * 現在の日付取得
	 *
	 */
	public Timesheet getCurrentTime(){
		timesheet = new Timesheet();

		Calendar calendar = Calendar.getInstance();
		Date currentDate = (Date) calendar.getTime();

		timesheet.setCurrentDate(currentDate);

		return timesheet;
	}


	/**
	 * 社員番号、会社コード設定メソッド
	 *
	 * @param bean  勤務表(月)
	 * @param empNo 社員番号
	 * @param comCode 会社コード
	 */
	private void setEmpNoAndComCode(Timesheet bean, String empNo, String comCode) {
		bean.setEmpNo(empNo);
		bean.setComCode(comCode);

		if (bean.getTimesheetDetailList() != null) {
			for (TimesheetDetail timesheetDetail: bean.getTimesheetDetailList()) {
				timesheetDetail.setEmpNo(empNo);
				timesheetDetail.setComCode(comCode);
			}
		}

		if (bean.getFixTimeList() != null) {
			for (FixTime fx: bean.getFixTimeList()) {
				fx.setEmpNo(empNo);
				fx.setComCode(comCode);
			}
		}
	}

	/**
	 * 勤務表一覧取得
	 * @see com.prms.timesheet.business.service.iface.TimesheetService#getTimesheetList(com.prms.timesheet.business.domain.Timesheet)
	 * @return List<Timesheet>
	 */
	@Override
	public List<Timesheet> getTimesheetList(){

		session = FlexContext.getFlexSession();
		Account account = (Account) session.getAttribute("account");

		List<Timesheet> list = (List<Timesheet>) timesheetDao.getTimesheetList(account);

		ListIterator<Timesheet> iter = list.listIterator();

		while(iter.hasNext()){

			timesheet = (Timesheet) iter.next();

			try {
				timesheet.setCodeDetailName(CodeDetailUtil.getCodeDetailName(Constants.CODE_TYPE_STATUS, timesheet.getStatusCode()));
				iter.set(timesheet);
			} catch (SQLException e) {
				logger.error(e.toString());
				throw new PrmsException(e);
			}
		}

		return list;
	}

	@Override
	public List<Timesheet> getTimesheetListByComCode(String comCode) {
		return timesheetDao.getTimesheetListByComCode(comCode);
	}

	public List<FixTime> getFixTimeList(FixTime bean) {
		return timesheetDao.getFixTimeList(bean);
	}

	/**
	 * 勤務表存在有無チェック
	 * @see com.prms.timesheet.business.service.iface.TimesheetService#existTimesheetByYYYYMM(com.prms.timesheet.business.domain.Timesheet)
	 * @param bean : 勤務表(月)ドメインクラス
	 */
	@Override
	public boolean existTimesheetByYYYYMM(Timesheet bean) {

		session = FlexContext.getFlexSession();

		Account account = (Account) session.getAttribute("account");

		bean.setEmpNo(account.getEmpNo());
		bean.setComCode(account.getComCode());

		boolean existTimesheet = false;
		existTimesheet = timesheetDao.existTimesheetByYYYYMM(bean);

		return existTimesheet;
	}

	/**
	 * 勤務表保存クラス
	 * 保存の際、エラーが発生した場合処理を中止する。
	 *
	 * @see com.prms.timesheet.business.service.iface.TimesheetService#updateTimesheet(com.prms.timesheet.business.domain.Timesheet)
	 * @param account 勤務表(月)ドメインクラス
	 * @return Message メッセージクラス
	 * @author 孫承範
	 */
	@Override
	public Message saveTimesheet(Timesheet bean) {

		// session処理
		session = FlexContext.getFlexSession();
		Account account = (Account) session.getAttribute("account");
		setEmpNoAndComCode(bean, account.getEmpNo(), account.getComCode());

		// 実行結果メッセージクラス
		Message message = null;

		// 勤務表更新
		if (existTimesheetByYYYYMM(bean)) {	// 勤務表が存在する場合 - 勤務表を削除してから登録を行う。
			// 勤務表削除処理
			message = timesheetDao.removeTimesheet(bean);
		} else {	// 勤務表が存在しない場合 - 勤務表ステータスを作成中に設定
			bean.setStatusCode(Constants.WRITE_STATUS);
		}

		// 勤務表(月)登録
		message = timesheetDao.saveTimesheet(bean);

		// 正常終了メッセージを返却
		return MessageUtil.getMessage("I", "0002");
	}

	/**
	 *勤務表妥当性検証メッソド
	 *
	 * @param timesheet 勤務表(月)ドメイン
	 * @author 久場
	 */
	public Message validateTimesheet(Timesheet bean) {

		// チェック処理のエラー取得用
		ValidatorResult validatorResult;

		// 定時情報チェックを行う
		validatorResult = Validator.isRequiredFixTime(bean.getFixTimeList());
		if (validatorResult != null) {
			// エラーメッセージを取得
			Message message = MessageUtil.getMessage(
					validatorResult.getMsgType(), validatorResult.getMsgId());
			// エラーメッセージを編集
			message.setMsgBody(
					"定時名称 : " +
					validatorResult.getErrorLocation() + "\n" +
					message.getMsgBody());
			logger.error(" * 定時情報　入力チェックにてエラー発生！！！　");
			logger.info(message.getMsgBody());
			return message;
		}
		//  勤務表（日）チェックを行う
		validatorResult = Validator.isRequiredTimesheetDetail(
				bean.getTimesheetDetailList());
		if (validatorResult != null) {
			Message message = MessageUtil.getMessage(
					validatorResult.getMsgType(), validatorResult.getMsgId());
			message.setMsgBody(
					"勤務表 日付 : " +
					validatorResult.getErrorLocation() + "\n" +
					message.getMsgBody());
			logger.error(" * 勤務表（日）　入力チェックにてエラー発生！！！　");
			logger.info(message.getMsgBody());
			return message;
		}
		return null;
	}

	/**
	 *勤務表計算ロジック
	 *
	 * @param timesheet 勤務表(月)ドメイン
	 * @author 孫承範
	 */
	public void calculateTimesheet(Timesheet bean) {

		//Timesheet BigDecimal 初期化
		initTimesheet(bean);

		for (TimesheetDetail timesheetDetail : bean.getTimesheetDetailList()) {
			// 勤務時間合計 ＝ 終業時間 - 始業時間
			timesheetDetail.setWorkTimeTotal(Calculator.diffTimeToBigDecimal(timesheetDetail.getWorkStartTime(), timesheetDetail.getWorkEndTime()));

			for (FixTime fixTime : bean.getFixTimeList()) {

				if (fixTime.getFixTimeName() == timesheetDetail.getFixTimeName()) {
					// お昼休み時間 ＝ お昼休み終了時間 － お昼休み開始時間
					timesheetDetail.setLunchBreakTime(Calculator.diffTimeToBigDecimal(fixTime.getLunchStartTime(), fixTime.getLunchEndTime()));

					// 超過勤務時間 = 終業時間(実) - 終業時間（定時）//終業時間（実）は22時以前まで
					// 深夜勤務時間 = 終業時間（実）- 22時	//22時－29時まで勤務
					// TODO 29時間を超える場合は？
					if (Integer.parseInt(timesheetDetail.getWorkEndTime()) > 2200) {	// 22時間を超える場合
						timesheetDetail.setOverWorkTime(Calculator.diffTimeToBigDecimal(fixTime.getWorkEndTime(), "2200"));
						timesheetDetail.setNightWorkTime(Calculator.diffTimeToBigDecimal("2200", timesheetDetail.getWorkEndTime()));
					} else { // 22時間を超えない場合
						timesheetDetail.setOverWorkTime(Calculator.diffTimeToBigDecimal(fixTime.getWorkEndTime(), timesheetDetail.getWorkEndTime()));
						timesheetDetail.setNightWorkTime(new BigDecimal(0.0));
					}

					// 遅刻時間 = 始業時間(日) - 始業時間(定時)
					timesheetDetail.setLateTime(Calculator.diffTimeToBigDecimal(fixTime.getWorkStartTime(), timesheetDetail.getWorkStartTime()));

					// 早退時間 = 終業時間(定時) - 終業時間(日)
					BigDecimal earlyTime = Calculator.diffTimeToBigDecimal(timesheetDetail.getWorkEndTime(), fixTime.getWorkEndTime());
					if (earlyTime.intValue() > 0) {
						timesheetDetail.setEarlyTime(Calculator.diffTimeToBigDecimal(timesheetDetail.getWorkEndTime(), fixTime.getWorkEndTime()));
					}
					if (logger.isDebugEnabled()) {

						logger.debug(" [ " + timesheetDetail.getYyyymmdd() + " ] ");
						logger.debug("勤務時間合計:" + timesheetDetail.getWorkTimeTotal() + "＝ 終業時間 :" + timesheetDetail.getWorkEndTime() + " - 始業時間:" + timesheetDetail.getWorkStartTime());
						logger.debug("お昼休み時間:" + timesheetDetail.getLunchBreakTime() + " ＝ お昼休み終了時間:" + fixTime.getLunchEndTime() + " － お昼休み開始時間:" + fixTime.getLunchStartTime());
						logger.debug("超過勤務時間 : " + timesheetDetail.getOverWorkTime());
						logger.debug("深夜勤務時間 : " + timesheetDetail.getNightWorkTime());
						logger.debug("遅刻時間:" + timesheetDetail.getLateTime() + "= 始業時間(日):" + timesheetDetail.getWorkStartTime() + " - 始業時間(定時):" + fixTime.getWorkStartTime());
						logger.debug("早退時間:" + timesheetDetail.getEarlyTime() + " = 終業時間(定時):" + fixTime.getWorkEndTime() + " - 終業時間(日):" + timesheetDetail.getWorkEndTime());
					}
				}
			}

			// 定時情報のお昼休み時間より休憩時間が多い場合
			// その他休憩時間 ＝ 休憩時間合計 - お昼休み時間
			if ((timesheetDetail.getBreakTimeTotal()).compareTo(timesheetDetail.getLunchBreakTime())  == 1 ) {
				System.out.println("<<< line 1");
				timesheetDetail.setEtcBreakTime(timesheetDetail.getBreakTimeTotal().add(timesheetDetail.getLunchBreakTime().negate()));
			} else {
				System.out.println("<<< line 2");
				timesheetDetail.setEtcBreakTime(new BigDecimal(0.0));
			}

			// 実働時間 ＝ 勤務時間合計 ー 休憩時間合計
			timesheetDetail.setActualTime(timesheetDetail.getWorkTimeTotal().add(timesheetDetail.getBreakTimeTotal().negate()));
			if (logger.isDebugEnabled()) {
				logger.debug("その他休憩時間:" + timesheetDetail.getEtcBreakTime() + " ＝ 休憩時間合計:" + timesheetDetail.getBreakTimeTotal() + "  - お昼休み時間:" + timesheetDetail.getLunchBreakTime());
				logger.debug("実働時間:" + timesheetDetail.getActualTime() + " ＝ 勤務時間合計:" + timesheetDetail.getWorkTimeTotal() + " ー 休憩時間合計:" + timesheetDetail.getBreakTimeTotal());
			}

			// TODO 休日
			// 休日勤務時間 = yyyymmddが土・日の場合 + 祝日
			//※ if 祝日はCalendarクラスで登録された日 → 休日
			//計算の方法は上記と同様

			// 月ごと計算
			bean.setActualTimeTotal(bean.getActualTimeTotal().add(timesheetDetail.getActualTime()));	// 実働時間合計
			bean.setBreakTimeTotal(bean.getBreakTimeTotal().add(timesheetDetail.getBreakTimeTotal()));	// 休憩時間合計
			bean.setOverTimeTotal(bean.getOverTimeTotal().add(timesheetDetail.getOverWorkTime()));	//超過勤務時間合計
			bean.setNightTimeTotal(bean.getNightTimeTotal().add(timesheetDetail.getNightWorkTime()));	// 深夜勤務時間合計
			bean.setHolidayTimeTotal(bean.getHolidayTimeTotal().add(timesheetDetail.getHolidayWorkTime()));	// 休日出勤時間合計
			bean.setLateTimeTotal(bean.getLateTimeTotal().add(timesheetDetail.getLateTime()));	// 遅刻時間合計
			bean.setEarlyTimeTotal(bean.getEarlyTimeTotal().add(timesheetDetail.getEarlyTime()));	// 早退時間合計
			if (timesheetDetail.getWorkPatternCode() == "休日") {	// 当月有休消合計
				bean.setThisMonthPvTotal(bean.getThisMonthPvTotal().add(new BigDecimal(1)));
			}
			if (timesheetDetail.getWorkPatternCode() == "欠勤") {	// 欠勤日数合計
				bean.setAbsenceDaysTotal(bean.getAbsenceDaysTotal().add(new BigDecimal(1)));
			}
		}
		if (logger.isDebugEnabled()) {
			logger.debug("===== 計算結果 =====");
			logger.debug("実働時間合計: " + bean.getActualTimeTotal());
			logger.debug("休憩時間合計: " + bean.getBreakTimeTotal());
			logger.debug("超過勤務時間合計: " + bean.getOverTimeTotal());
			logger.debug("深夜勤務時間合計: " + bean.getNightTimeTotal());
			logger.debug("休日出勤時間合計: " + bean.getHolidayTimeTotal());
			logger.debug("遅刻時間合計: " + bean.getLateTimeTotal());
			logger.debug("早退時間合計: " + bean.getEarlyTimeTotal());
			logger.debug("当月有休消合計: " + bean.getThisMonthPvTotal());
			logger.debug("欠勤日数合計: " + bean.getAbsenceDaysTotal());
		}
	}

	/**
	 * Timesheet 初期化メソッド
	 * 勤務表(月)合計計算のためBigDecimalの初期値を設定
	 *
	 * @author 孫承範
	 */
	private void initTimesheet(Timesheet bean) {

		for (TimesheetDetail timesheetDetail:bean.getTimesheetDetailList()) {
			timesheetDetail.setWorkTimeTotal(new BigDecimal(0.0));
			timesheetDetail.setLunchBreakTime(new BigDecimal(0.0));
			timesheetDetail.setEtcBreakTime(new BigDecimal(0.0));
			timesheetDetail.setBreakTimeTotal(new BigDecimal(0.0));
			timesheetDetail.setActualTime(new BigDecimal(0.0));
			timesheetDetail.setOverWorkTime(new BigDecimal(0.0));
			timesheetDetail.setNightWorkTime(new BigDecimal(0.0));
			timesheetDetail.setHolidayWorkTime(new BigDecimal(0.0));
			timesheetDetail.setLateTime(new BigDecimal(0.0));
			timesheetDetail.setEarlyTime(new BigDecimal(0.0));
		}

    	bean.setActualTimeTotal(new BigDecimal(0.0));
    	bean.setBreakTimeTotal(new BigDecimal(0.0));
    	bean.setOverTimeTotal(new BigDecimal(0.0));
    	bean.setNightTimeTotal(new BigDecimal(0.0));
    	bean.setHolidayTimeTotal(new BigDecimal(0.0));
    	bean.setLateTimeTotal(new BigDecimal(0.0));
    	bean.setEarlyTimeTotal(new BigDecimal(0.0));
    	bean.setThisMonthPvTotal(new BigDecimal(0.0));
    	bean.setAbsenceDaysTotal(new BigDecimal(0.0));
	}

	// DEPENDENCY INJECTION
	public void setTimesheetDao(TimesheetDao timesheetDao) {
		this.timesheetDao = timesheetDao;
	}

	/**
	 * 勤務形態取得メソッド
	 *
	 * @see com.prms.timesheet.business.service.iface.TimesheetService#getWorkPattern()
	 * @return 勤務形態リスト
	 * @author 孫承範
	 */
	@Override
	public List<CodeDetail> getWorkPattern() {
		return timesheetDao.getWorkPattern();
	}

	/**
	 * 会社コードと年月を利用し、全社員の勤務表を取得
	 * @param bean 勤務表
	 * @return 勤務表リスト
	 */
	@Override
	public List<Timesheet> getTimesheetListByComCodeAndYYYYMM(Timesheet bean) {
		return timesheetDao.getTimesheetListByComCodeAndYYYYMM(bean);
	}

	/**
	 * 勤務表詳細画面データを取得
	 * @see com.prms.service.TimesheetService#showTimesheetDetail(com.prms.model.Timesheet)
	 */
	@Override
	public Timesheet getTimesheetDetail(Timesheet bean) {
		return timesheetDao.getTimesheetDetail(bean);
	}
}
