package com.prms.model;

import java.math.BigDecimal;
import java.sql.Date;

public class TrafficIrregular {

	/** 会社コード */
	private String comCode;

	/** 社員番号 */
	private String empNo;

	/** 年月 */
	private Date yyyymm;

	/** 出発地 */
	private String departurePoint;

	/** 到着地 */
	private String arrivalPoint;

	/** 開始日 */
	private Date startDate;

	/** 終了日 */
	private Date endDate;

	/** 金額 */
	private BigDecimal fare;

	/** 備考 */
	private String note;

	/** 片道金額（定価） */
	private BigDecimal oneWayFixedFare;

	/** 片道金額（バスカード利用金額） */
	private BigDecimal oneWayDcFare;

	/** 更新者ID */
	private String updateId;

	/** 更新日 */
	private Date updateDate;

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

	public String getDeparturePoint() {
		return departurePoint;
	}

	public void setDeparturePoint(String departurePoint) {
		this.departurePoint = departurePoint;
	}

	public String getArrivalPoint() {
		return arrivalPoint;
	}

	public void setArrivalPoint(String arrivalPoint) {
		this.arrivalPoint = arrivalPoint;
	}

	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	public BigDecimal getFare() {
		return fare;
	}

	public void setFare(BigDecimal fare) {
		this.fare = fare;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	public BigDecimal getOneWayFixedFare() {
		return oneWayFixedFare;
	}

	public void setOneWayFixedFare(BigDecimal oneWayFixedFare) {
		this.oneWayFixedFare = oneWayFixedFare;
	}

	public BigDecimal getOneWayDcFare() {
		return oneWayDcFare;
	}

	public void setOneWayDcFare(BigDecimal oneWayDcFare) {
		this.oneWayDcFare = oneWayDcFare;
	}

	public String getUpdateId() {
		return updateId;
	}

	public void setUpdateId(String updateId) {
		this.updateId = updateId;
	}

	public Date getUpdateDate() {
		return updateDate;
	}

	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}


	public String toString(){
		StringBuffer buffer = new StringBuffer();
		buffer.append("Traffic Irregular[");
		buffer.append(" comCode = ").append(comCode);
		buffer.append(" empNo = ").append(empNo);
		buffer.append(" yyyymm = ").append(yyyymm);
		buffer.append(" departurePoint = ").append(departurePoint);
		buffer.append(" arrivalPoint = ").append(arrivalPoint);
		buffer.append(" startDate = ").append(startDate);
		buffer.append(" endDate = ").append(endDate);
		buffer.append(" fare = ").append(fare);
		buffer.append(" note = ").append(note);
		buffer.append(" oneWayFixedFare = ").append(oneWayFixedFare);
		buffer.append(" oneWayDcFare = ").append(oneWayDcFare);
		buffer.append(" updateId = ").append(updateId);
		buffer.append(" updateDate = ").append(updateDate);
		buffer.append("]");
		return buffer.toString();
	}
}
