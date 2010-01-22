package com.prms.model;

import java.sql.Date;

public class Dept {

	private int level;

	private String comCode;

	private String deptCode;

	private Date regDay;

	private Date delDay;

	private String latestFlag;

	private String deptName;

	private String upperDeptCode;

	public int getLevel() {
		return level;
	}

	public void setLevel(int level) {
		this.level = level;
	}

	public String getComCode() {
		return comCode;
	}

	public void setComCode(String comCode) {
		this.comCode = comCode;
	}

	public String getDeptCode() {
		return deptCode;
	}

	public void setDeptCode(String deptCode) {
		this.deptCode = deptCode;
	}

	public Date getRegDay() {
		return regDay;
	}

	public void setRegDay(Date regDay) {
		this.regDay = regDay;
	}

	public Date getDelDay() {
		return delDay;
	}

	public void setDelDay(Date delDay) {
		this.delDay = delDay;
	}

	public String getLatestFlag() {
		return latestFlag;
	}

	public void setLatestFlag(String latestFlag) {
		this.latestFlag = latestFlag;
	}

	public String getDeptName() {
		return deptName;
	}

	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}

	public String getUpperDeptCode() {
		return upperDeptCode;
	}

	public void setUpperDeptCode(String upperDeptCode) {
		this.upperDeptCode = upperDeptCode;
	}

	public String toString() {
		StringBuffer buffer = new StringBuffer();
		buffer.append("Dept[");
		buffer.append(" level = ").append(level);
		buffer.append(" comCode = ").append(comCode);
		buffer.append(" deptCode = ").append(deptCode);
		buffer.append(" regDay = ").append(regDay);
		buffer.append(" delDay = ").append(delDay);
		buffer.append(" latestFlag = ").append(latestFlag);
		buffer.append(" deptName = ").append(deptName);
		buffer.append(" upperDeptCode = ").append(upperDeptCode);
		buffer.append("]");
		return buffer.toString();
	}

}
