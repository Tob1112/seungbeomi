package com.prms.model;

import java.sql.Date;
import java.math.BigDecimal;

/**
 * 定時情報ドメインクラス
 * @author developer002
 *
 */
public class FixTime{
    /** 会社コード */
    private String comCode;

    /** 社員番号 */
    private String empNo;

    /** 年月 */
    private Date yyyymm;

    /** 定時名称 */
    private String fixTimeName;

    /** 顧客名 */
    private String clientName;

    /** 時間単位 */
    private BigDecimal timeUnit;

    /** 始業時間 */
    private String workStartTime;

    /** 終業時間 */
    private String workEndTime;

    /** お昼休み開始時間 */
    private String lunchStartTime;

    /** お昼休み終了時間 */
    private String lunchEndTime;

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

	public String getFixTimeName() {
		return fixTimeName;
	}

	public void setFixTimeName(String fixTimeName) {
		this.fixTimeName = fixTimeName;
	}

	public String getClientName() {
		return clientName;
	}

	public void setClientName(String clientName) {
		this.clientName = clientName;
	}

	public BigDecimal getTimeUnit() {
		return timeUnit;
	}

	public void setTimeUnit(BigDecimal timeUnit) {
		this.timeUnit = timeUnit;
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

	public String getLunchStartTime() {
		return lunchStartTime;
	}

	public void setLunchStartTime(String lunchStartTime) {
		this.lunchStartTime = lunchStartTime;
	}

	public String getLunchEndTime() {
		return lunchEndTime;
	}

	public void setLunchEndTime(String lunchEndTime) {
		this.lunchEndTime = lunchEndTime;
	}

	public String toString() {
		StringBuffer buffer = new StringBuffer();
		buffer.append("FixTime[");
		buffer.append(" clientName = ").append(clientName);
		buffer.append(" comCode = ").append(comCode);
		buffer.append(" empNo = ").append(empNo);
		buffer.append(" fixTimeName = ").append(fixTimeName);
		buffer.append(" lunchEndTime = ").append(lunchEndTime);
		buffer.append(" lunchStartTime = ").append(lunchStartTime);
		buffer.append(" timeUnit = ").append(timeUnit);
		buffer.append(" workEndTime = ").append(workEndTime);
		buffer.append(" workStartTime = ").append(workStartTime);
		buffer.append(" yyyymm = ").append(yyyymm);
		buffer.append("]");
		return buffer.toString();
	}
}
