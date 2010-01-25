package com.prms.dao;

import java.util.List;

import com.prms.model.Account;
import com.prms.model.CodeDetail;
import com.prms.model.FixTime;
import com.prms.model.Message;
import com.prms.model.Timesheet;

public interface TimesheetDao {

	/** 勤務表(月), 勤務表(日), 定時情報を取得 */
	Timesheet getTimesheetAndChildByPk(Timesheet bean);

	/** 勤務表一覧取得 */
	List<Timesheet> getTimesheetList(Account bean);

	/** 会社コードを入力し、該当会社の勤務表リストを取得 */
	List<Timesheet> getTimesheetListByComCode(String comCode);

	/** 勤務形態取得メソッド */
	List<CodeDetail> getWorkPattern();

	List<FixTime> getFixTimeList(FixTime bean);

	/** 勤務表存在有無チェック */
	boolean existTimesheetByYYYYMM(Timesheet bean);

	/** 勤務表登録 */
	Message saveTimesheet(Timesheet bean);

	/** 勤務表削除 */
	Message removeTimesheet(Timesheet bean);

	/** 勤務表一覧取得 */
	List<Timesheet> getTimesheetListByComCodeAndYYYYMM(Timesheet bean);

	/** 勤務表詳細情報データーを取得*/
	Timesheet getTimesheetDetail(Timesheet bean);

	Timesheet getTimesheetSummary(Timesheet bean);

	List<Timesheet> compareTimesheet(List<Timesheet> list);
}
