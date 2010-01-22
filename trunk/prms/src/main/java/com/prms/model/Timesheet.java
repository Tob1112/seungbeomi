package com.prms.model;

import java.sql.Date;
import java.util.List;
import java.math.BigDecimal;

/**
 * 勤務表 (月)ドメインクラス
 * @author developer002
 *
 */
public class Timesheet {

	/** 会社コード */
    private String comCode;

    /** 社員番号 */
    private String empNo;

    /** 年月 */
    private Date yyyymm;

    /** 確定フラグ */
    private String fixFlag;

    /** ステータスコード */
    private String statusCode;

    /** 実働時間合計 */
    private BigDecimal actualTimeTotal;

    /** 休憩時間合計 */
    private BigDecimal breakTimeTotal;

    /** 超過勤務時間合計 */
    private BigDecimal overTimeTotal;

    /** 深夜勤務時間合計 */
    private BigDecimal nightTimeTotal;

    /** 休日出勤時間合計 */
    private BigDecimal holidayTimeTotal;

    /** 遅刻時間合計 */
    private BigDecimal lateTimeTotal;

    /** 早退時間合計 */
    private BigDecimal earlyTimeTotal;

    /** 当月有休消合計 */
    private BigDecimal thisMonthPvTotal;

    /** 欠勤日数合計 */
    private BigDecimal absenceDaysTotal;

    /**  定時情報 リスト */
    private List<FixTime> fixTimeList;

    /** 勤務表(日) リスト */
    private List<TimesheetDetail> timesheetDetailList;

    /** 社員名（姓） */
	private String lastName;

	/** 社員名（名） */
	private String firstName;

	/** 現在の日付 */
	private java.util.Date currentDate;

	/** コードネーム */
	private String codeDetailName;

	public String getCodeDetailName() {
		return codeDetailName;
	}

	public void setCodeDetailName(String codeDetailName) {
		this.codeDetailName = codeDetailName;
	}

	public java.util.Date getCurrentDate() {
		return currentDate;
	}

	public void setCurrentDate(java.util.Date currentDate) {
		this.currentDate = currentDate;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getComCode() {
		return comCode;
	}

	public void setComCode(String comCode) {
		this.comCode = comCode;
	}

	public String getEmpNo() {
		return empNo;
	}

	public void setEmpNo(String empNo) {
		this.empNo = empNo;
	}

	public Date getYyyymm() {
		return yyyymm;
	}

	public void setYyyymm(Date yyyymm) {
		this.yyyymm = yyyymm;
	}

	public String getFixFlag() {
		return fixFlag;
	}

	public void setFixFlag(String fixFlag) {
		this.fixFlag = fixFlag;
	}

	public String getStatusCode() {
		return statusCode;
	}

	public void setStatusCode(String statusCode) {
		this.statusCode = statusCode;
	}

	public BigDecimal getActualTimeTotal() {
		return actualTimeTotal;
	}

	public void setActualTimeTotal(BigDecimal actualTimeTotal) {
		this.actualTimeTotal = actualTimeTotal;
	}

	public BigDecimal getBreakTimeTotal() {
		return breakTimeTotal;
	}

	public void setBreakTimeTotal(BigDecimal breakTimeTotal) {
		this.breakTimeTotal = breakTimeTotal;
	}

	public BigDecimal getOverTimeTotal() {
		return overTimeTotal;
	}

	public void setOverTimeTotal(BigDecimal overTimeTotal) {
		this.overTimeTotal = overTimeTotal;
	}

	public BigDecimal getNightTimeTotal() {
		return nightTimeTotal;
	}

	public void setNightTimeTotal(BigDecimal nightTimeTotal) {
		this.nightTimeTotal = nightTimeTotal;
	}

	public BigDecimal getHolidayTimeTotal() {
		return holidayTimeTotal;
	}

	public void setHolidayTimeTotal(BigDecimal holidayTimeTotal) {
		this.holidayTimeTotal = holidayTimeTotal;
	}

	public BigDecimal getLateTimeTotal() {
		return lateTimeTotal;
	}

	public void setLateTimeTotal(BigDecimal lateTimeTotal) {
		this.lateTimeTotal = lateTimeTotal;
	}

	public BigDecimal getEarlyTimeTotal() {
		return earlyTimeTotal;
	}

	public void setEarlyTimeTotal(BigDecimal earlyTimeTotal) {
		this.earlyTimeTotal = earlyTimeTotal;
	}

	public BigDecimal getThisMonthPvTotal() {
		return thisMonthPvTotal;
	}

	public void setThisMonthPvTotal(BigDecimal thisMonthPvTotal) {
		this.thisMonthPvTotal = thisMonthPvTotal;
	}

	public BigDecimal getAbsenceDaysTotal() {
		return absenceDaysTotal;
	}

	public void setAbsenceDaysTotal(BigDecimal absenceDaysTotal) {
		this.absenceDaysTotal = absenceDaysTotal;
	}

	public List<FixTime> getFixTimeList() {
		return fixTimeList;
	}

	public void setFixTimeList(List<FixTime> fixTimeList) {
		this.fixTimeList = fixTimeList;
	}

	public List<TimesheetDetail> getTimesheetDetailList() {
		return timesheetDetailList;
	}

	public void setTimesheetDetailList(List<TimesheetDetail> timesheetDetailList) {
		this.timesheetDetailList = timesheetDetailList;
	}

	public String toString() {
		StringBuffer buffer = new StringBuffer();
		buffer.append("Timesheet[");
		buffer.append(" empNo = ").append(empNo);
		buffer.append(" lastName = ").append(lastName);
		buffer.append(" firstName = ").append(firstName);
		buffer.append(" codeDetailName = ").append(codeDetailName);
		buffer.append(" absenceDaysTotal = ").append(absenceDaysTotal);
		buffer.append(" actualTimeTotal = ").append(actualTimeTotal);
		buffer.append(" breakTimeTotal = ").append(breakTimeTotal);
		buffer.append(" comCode = ").append(comCode);
		buffer.append(" earlyTimeTotal = ").append(earlyTimeTotal);
		buffer.append(" fixFlag = ").append(fixFlag);
		buffer.append(" fixTimeList = ").append(fixTimeList);
		buffer.append(" holidayTimeTotal = ").append(holidayTimeTotal);
		buffer.append(" lateTimeTotal = ").append(lateTimeTotal);
		buffer.append(" nightTimeTotal = ").append(nightTimeTotal);
		buffer.append(" overTimeTotal = ").append(overTimeTotal);
		buffer.append(" statusCode = ").append(statusCode);
		buffer.append(" thisMonthPvTotal = ").append(thisMonthPvTotal);
		buffer.append(" timesheetDetailList = ").append(timesheetDetailList);
		buffer.append(" yyyymm = ").append(yyyymm);
		buffer.append("]");
		return buffer.toString();
	}
}
