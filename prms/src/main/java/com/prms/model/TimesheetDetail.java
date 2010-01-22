package com.prms.model;

import java.sql.Date;
import java.math.BigDecimal;

/**
 * 勤務表（日）ドメインクラス
 * @author 孫承範
 */
public class TimesheetDetail  {
	/** 会社コード */
	private String comCode;

	/** 社員番号 */
	private String empNo;

	/** 年月 */
	private Date yyyymm;

	/** 年月日 */
	private Date yyyymmdd;

	/** 勤務形態コード */
	private String workPatternCode;

	/** 定時名称 */
	private String fixTimeName;

	/** 始業時間 */
	private String workStartTime;

	/** 終業時間 */
	private String workEndTime;

	/** 勤務時間合計 */
	private BigDecimal workTimeTotal;

	/** お休み時間 */
	private BigDecimal lunchBreakTime;

	/** その他休憩時間 */
	private BigDecimal etcBreakTime;

	/** 休憩時間合計 */
	private BigDecimal breakTimeTotal;

	/** 実動時間 */
	private BigDecimal actualTime;

	/** 超過勤務時間 */
	private BigDecimal overWorkTime;

	/** 深夜勤務時間 */
	private BigDecimal nightWorkTime;

	/** 休日勤務時間 */
	private BigDecimal holidayWorkTime;

	/** 遅刻時間 */
	private BigDecimal lateTime;

	/** 早退時間 */
	private BigDecimal earlyTime;

	/** 備考 */
	private String note;

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

	public Date getYyyymmdd() {
		return yyyymmdd;
	}

	public void setYyyymmdd(Date yyyymmdd) {
		this.yyyymmdd = yyyymmdd;
	}

	public String getWorkPatternCode() {
		return workPatternCode;
	}

	public void setWorkPatternCode(String workPatternCode) {
		this.workPatternCode = workPatternCode;
	}

	public String getFixTimeName() {
		return fixTimeName;
	}

	public void setFixTimeName(String fixTimeName) {
		this.fixTimeName = fixTimeName;
	}

	public String getWorkStartTime() {
		return workStartTime;
	}

	public void setWorkStartTime(String workStartTime) {
		this.workStartTime = workStartTime;
	}

	public String getWorkEndTime() {
		return workEndTime;
	}

	public void setWorkEndTime(String workEndTime) {
		this.workEndTime = workEndTime;
	}

	public BigDecimal getWorkTimeTotal() {
		return workTimeTotal;
	}

	public void setWorkTimeTotal(BigDecimal workTimeTotal) {
		this.workTimeTotal = workTimeTotal;
	}

	public BigDecimal getLunchBreakTime() {
		return lunchBreakTime;
	}

	public void setLunchBreakTime(BigDecimal lunchBreakTime) {
		this.lunchBreakTime = lunchBreakTime;
	}

	public BigDecimal getEtcBreakTime() {
		return etcBreakTime;
	}

	public void setEtcBreakTime(BigDecimal etcBreakTime) {
		this.etcBreakTime = etcBreakTime;
	}

	public BigDecimal getBreakTimeTotal() {
		return breakTimeTotal;
	}

	public void setBreakTimeTotal(BigDecimal breakTimeTotal) {
		this.breakTimeTotal = breakTimeTotal;
	}

	public BigDecimal getActualTime() {
		return actualTime;
	}

	public void setActualTime(BigDecimal actualTime) {
		this.actualTime = actualTime;
	}

	public BigDecimal getOverWorkTime() {
		return overWorkTime;
	}

	public void setOverWorkTime(BigDecimal overWorkTime) {
		this.overWorkTime = overWorkTime;
	}

	public BigDecimal getNightWorkTime() {
		return nightWorkTime;
	}

	public void setNightWorkTime(BigDecimal nightWorkTime) {
		this.nightWorkTime = nightWorkTime;
	}

	public BigDecimal getHolidayWorkTime() {
		return holidayWorkTime;
	}

	public void setHolidayWorkTime(BigDecimal holidayWorkTime) {
		this.holidayWorkTime = holidayWorkTime;
	}

	public BigDecimal getLateTime() {
		return lateTime;
	}

	public void setLateTime(BigDecimal lateTime) {
		this.lateTime = lateTime;
	}

	public BigDecimal getEarlyTime() {
		return earlyTime;
	}

	public void setEarlyTime(BigDecimal earlyTime) {
		this.earlyTime = earlyTime;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	public String toString() {
		StringBuffer buffer = new StringBuffer();
		buffer.append("TimesheetDetail[");
		buffer.append(" actualTime = ").append(actualTime);
		buffer.append(" breakTimeTotal = ").append(breakTimeTotal);
		buffer.append(" comCode = ").append(comCode);
		buffer.append(" earlyTime = ").append(earlyTime);
		buffer.append(" empNo = ").append(empNo);
		buffer.append(" etcBreakTime = ").append(etcBreakTime);
		buffer.append(" fixTimeName = ").append(fixTimeName);
		buffer.append(" holidayWorkTime = ").append(holidayWorkTime);
		buffer.append(" lateTime = ").append(lateTime);
		buffer.append(" lunchBreakTime = ").append(lunchBreakTime);
		buffer.append(" nightWorkTime = ").append(nightWorkTime);
		buffer.append(" note = ").append(note);
		buffer.append(" overWorkTime = ").append(overWorkTime);
		buffer.append(" workEndTime = ").append(workEndTime);
		buffer.append(" workPatternCode = ").append(workPatternCode);
		buffer.append(" workStartTime = ").append(workStartTime);
		buffer.append(" workTimeTotal = ").append(workTimeTotal);
		buffer.append(" yyyymm = ").append(yyyymm);
		buffer.append(" yyyymmdd = ").append(yyyymmdd);
		buffer.append("]");
		return buffer.toString();
	}
}
