package com.prms.service;

import java.util.List;

import com.prms.model.CodeDetail;
import com.prms.model.FixTime;
import com.prms.model.Message;
import com.prms.model.Timesheet;

/**
 * 勤務表インターフェイス
 *
 * @author 孫承範
 * @author
 */
public interface TimesheetService {

	/**
	 * 勤務表(月), 勤務表(日), 定時情報を取得
	 *
	 * @param bean 勤務表(月)
	 * @author
	 */
	public Timesheet getTimesheetAndChildByPk(Timesheet bean);

	/**
	 * 勤務表一覧取得
	 *
	 * @param bean
	 * @author
	 */
	public List<Timesheet> getTimesheetList();

	/**
	 * 会社コードを入力し、勤務表リストを取得
	 */
	public List<Timesheet> getTimesheetListByComCode(String comCode);

	public List<FixTime> getFixTimeList(FixTime bean);

	/**
	 * 勤務表存在有無チェック
	 * @param bean
	 * @return
	 */
	public boolean existTimesheetByYYYYMM(Timesheet bean);

	/**
	 * 勤務表保存クラス
	 *
	 * @param bean 勤務表（月）ドメインクラス
	 * @return Message メッセージクラス
	 * @author 孫承範
	 */
	public Message saveTimesheet(Timesheet bean);


	/**
	 * セッションから社員名取得
	 *
	 * @return bean
	 */
	public Timesheet getEmpNameBySession();


	/**
	 * 現在の日付取得
	 *
	 * @return bean
	 */
	public Timesheet getCurrentTime();

	/**
	 * 勤務形態取得メソット
	 *
	 * @return 勤務形態リスト
	 * @author 孫承範
	 */
	public List<CodeDetail> getWorkPattern();


	/**
	 * 会社コードと年月を利用し、全社員の勤務表を取得
	 * @param bean 勤務表
	 * @return 勤務表リスト
	 */
	public List<Timesheet> getTimesheetListByComCodeAndYYYYMM(Timesheet bean);

	/**
	 * 勤務表詳細情報取得
	 * @param bean 勤務表
	 * @return
	 */
	public Timesheet getTimesheetDetail(Timesheet bean);

	/**
	 *勤務表妥当性検証メッソド
	 *
	 * @param timesheet 勤務表(月)ドメイン
	 * @author 久場
	 */
	public Message validateTimesheet(Timesheet bean);

	/**
	 *勤務表計算ロジック
	 *
	 * @param timesheet 勤務表(月)ドメイン
	 * @author 孫承範
	 */
	public void calculateTimesheet(Timesheet bean);

}
