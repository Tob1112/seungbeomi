package com.prms.dao.impl;

import java.sql.SQLException;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.springframework.orm.ibatis.SqlMapClientCallback;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;
import org.springframework.security.annotation.Secured;

import com.ibatis.sqlmap.client.SqlMapExecutor;
import com.prms.Constants;
import com.prms.dao.TimesheetDao;
import com.prms.exception.PrmsException;
import com.prms.model.Account;
import com.prms.model.CodeDetail;
import com.prms.model.FixTime;
import com.prms.model.Message;
import com.prms.model.Timesheet;
import com.prms.model.TimesheetDetail;
import com.prms.util.CodeDetailUtil;
import com.prms.util.MessageUtil;

/**
 * 勤務表(月)実装クラス
 *
 * @author 孫承範
 */
public class TimesheetDaoImpl extends SqlMapClientDaoSupport implements TimesheetDao{

	/**
	 * 勤務表(月), 勤務表(日), 定時情報取得
	 *
	 * @param bean : 勤務表(月)
	 * @return Timesheet : 勤務表(月)
	 * @author
	 */
	@Override
	public Timesheet getTimesheetAndChildByPk(Timesheet bean) {

		Timesheet timesheet = (Timesheet) getSqlMapClientTemplate().queryForObject("timesheet.getTimesheetAndChildByPk", bean);

		zeroToNull(timesheet);

		return timesheet;
	}

	private void zeroToNull(Timesheet bean) {
		for (TimesheetDetail timesheetDetail: bean.getTimesheetDetailList()) {
			// 勤務表詳細の休憩と実働時間が無効な値の場合(-99999)にはNullを返す。
			System.out.println("<<< " + timesheetDetail.getBreakTimeTotal().intValue() + " " +  timesheetDetail.getActualTime().intValue());
			if (timesheetDetail.getBreakTimeTotal().intValue() == 0) {
				timesheetDetail.setBreakTimeTotal(null);
			}
			if (timesheetDetail.getActualTime().intValue() == 0) {
				timesheetDetail.setActualTime(null);
			} else {
				timesheetDetail.setActualTime(timesheetDetail.getActualTime().setScale(2));
			}
		}
	}

	/**
	 * 勤務表一覧取得
	 *
	 * @see com.prms.timesheet.persistence.iface.TimesheetDao#getTimesheetList
	 * @param bean
	 */
	@Override
	public List<Timesheet> getTimesheetList(Account bean) {
		return (List<Timesheet>) getSqlMapClientTemplate().queryForList("timesheet.getTimesheetList", bean);
	}

	@Override
	public List<Timesheet> getTimesheetListByComCode(String comCode) {
		return (List<Timesheet>) getSqlMapClientTemplate().queryForList("timesheet.getTimesheetListByComCode", comCode);
	}

	/**
	 * 勤務形態取得メソッド
	 *
	 * @see com.prms.timesheet.persistence.iface.TimesheetDao#getWorkPattern()
	 * @return 勤務形態リスト
	 * @author 孫承範
	 */
	@Override
	public List<CodeDetail> getWorkPattern() {
		return getSqlMapClientTemplate().queryForList("timesheetDetail.getWorkPattern");
	}

	@Override
	public List<FixTime> getFixTimeList(FixTime bean) {
		return getSqlMapClientTemplate().queryForList("ｆixTime.getFixTimeList", bean);
	}

	/**
	 * 勤務表存在有無確認メッソド
	 *
	 * @see com.prms.timesheet.persistence.iface.TimesheetDao#existTimesheetByYYYYMM(java.util.Date)
	 * @param bean 勤務表(月)ドメイン
	 * @author 孫承範
	 */
	@Override
	public boolean existTimesheetByYYYYMM(Timesheet bean) {
		Object result =  getSqlMapClientTemplate().queryForObject("timesheet.existTimesheetByYYYYMM", bean);
		return result == null ? false: true;
	}

	/**
	 * 勤務表(月)登録メッソド
	 *
	 * @see com.prms.timesheet.persistence.iface.TimesheetDao#saveTimesheet(com.prms.timesheet.business.domain.Timesheet)
	 * @param bean 勤務表(月)ドメイン
	 * @return Message メッセージクラス
	 * @author 孫承範
	 */
	@Override
	@Secured({"ROLE_ADMIN","ROLE_USER"})
	public Message saveTimesheet(final Timesheet bean) {

		/* ROLE CHECK !!!
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		if (request.isUserInRole("ROLE_ADMIN")) {
			System.out.println("<<<<<<<<<<<<<< role admin");
		} else if (request.isUserInRole("ROLE_USER")) {
			System.out.println("<<<<<<<<<<<<<< role user");
		} else {
			throw new AccessDeniedException("You must be get authentication (Spring Security message)");
		}
		*/

		try {
			getSqlMapClientTemplate().execute(new SqlMapClientCallback() {
				@Override
				public Object doInSqlMapClient(SqlMapExecutor executor) throws SQLException {
					executor.startBatch();

					executor.insert("timesheet.saveTimesheet",bean);

					for (TimesheetDetail timesheetDetail: bean.getTimesheetDetailList()) {
						executor.insert("timesheetDetail.saveTimesheetDetail", timesheetDetail);
					}

					for (FixTime fixTime: bean.getFixTimeList()) {
						executor.insert("fixTime.saveFixTime", fixTime);
					}
					executor.executeBatch();
					return null;
				}
			});
		} catch (Exception e) {
			logger.error(e.toString());
			Message message = MessageUtil.getMessage("E", "0001");
			e.printStackTrace();
			throw new PrmsException(message.getMsgBody(), e);
		}
		return MessageUtil.getMessage("I", "0001");
	}

	/**
	 * 勤務表(月)削除メッソド
	 *
	 * @see com.prms.timesheet.persistence.iface.TimesheetDao#removeTimesheetByYYYYMM(java.sql.Date)
	 * @param yyyymm 年月
	 * @return Message メッセージクラス
	 * @author 孫承範
	 */
	@Override
	public Message removeTimesheet(final Timesheet bean) {
		try {
			getSqlMapClientTemplate().execute(new SqlMapClientCallback() {
				@Override
				public Object doInSqlMapClient(SqlMapExecutor executor) throws SQLException {
					executor.startBatch();
					executor.delete("timesheet.removeTimesheet",bean);

					for (TimesheetDetail timesheetDetail: bean.getTimesheetDetailList()) {
						executor.delete("timesheetDetail.removeTimesheetDetail", timesheetDetail);
					}

					for (FixTime fixTime: bean.getFixTimeList()) {
						executor.delete("fixTime.removeFixTime", fixTime);
					}
					executor.executeBatch();
					return null;
				}
			});
		} catch (Exception e) {
			logger.error(e.toString());
			Message message = MessageUtil.getMessage("E", "0001");
			throw new PrmsException(message.getMsgBody(), e);
		}
		return MessageUtil.getMessage("I", "0001");
	}

	/* (non-Javadoc)
	 * @see com.prms.dao.TimesheetDao#getTimesheetListByComCodeAndYYYYMM(com.prms.model.Timesheet)
	 */
	@Override
	public List<Timesheet> getTimesheetListByComCodeAndYYYYMM(Timesheet bean) {
		List<Timesheet> timesheetList = (List<Timesheet>) getSqlMapClientTemplate().queryForList("timesheet.getTimesheetListByComCodeAndYYYYMM", bean);

		for (Timesheet timesheet : timesheetList) {
			try {
				timesheet.setCodeDetailName(CodeDetailUtil.getCodeDetailName(Constants.CODE_TYPE_STATUS, timesheet.getStatusCode()));
			} catch (SQLException e) {
				e.printStackTrace();
				Message message = MessageUtil.getMessage("E", "0001");
				throw new PrmsException(message.getMsgBody(), e);
			}
		}

		return timesheetList;
	}

	/**
	 * 勤務表詳細データを取得
	 *
	 * @see com.prms.dao.TimesheetDao#showTimesheetDetail(com.prms.model.Timesheet)
	 */
	@Override
	public Timesheet getTimesheetDetail(Timesheet bean) {
		Timesheet timesheet = (Timesheet) getSqlMapClientTemplate().queryForObject("timesheet.getTimesheetDetail", bean);

		// 現在時間取得
		Calendar calendar = Calendar.getInstance();
		Date currentDate = (Date) calendar.getTime();
		timesheet.setCurrentDate(currentDate);

		// codeDetailName取得
		try {
			timesheet.setCodeDetailName(CodeDetailUtil.getCodeDetailName(Constants.CODE_TYPE_STATUS, timesheet.getStatusCode()));
			zeroToNull(timesheet);
		} catch (SQLException e) {
			e.printStackTrace();
			Message message = MessageUtil.getMessage("E", "0001");
			throw new PrmsException(message.getMsgBody(), e);
		}
		return timesheet;
	}

	@Override
	public Timesheet getTimesheetSummary(Timesheet bean) {
		return (Timesheet) getSqlMapClientTemplate().queryForObject("timesheet.getTimesheetSummary", bean);
	}

}
