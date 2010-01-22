package com.prms.model;

import java.math.BigDecimal;
import java.sql.Date;

public class TrafficRegular {

	/** 会社コード */
	private String comCode;

	/** 社員番号 */
	private String empNo;

	/** 出発地 */
	private String departurePoint;

	/** 到着地 */
	private String arrivalPoint;

	/** 年月 */
	private Date yyyymm;

	/** 年月日 */
	private Date yyyymmdd;

	/** 電車代 */
	private BigDecimal trainFare;

	/** バス代 */
	private BigDecimal busFare;

	/** その他 */
	private BigDecimal otherFare;

	/** 備考 */
	private String note;

	/** タクシー代 */
	private BigDecimal taxiFare;

	/** 宿泊費 */
	private BigDecimal hotelFare;

	/** 区分（01:通勤分, 02:業務分） */
	private String division;

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

	public BigDecimal getTrainFare() {
		return trainFare;
	}

	public void setTrainFare(BigDecimal trainFare) {
		this.trainFare = trainFare;
	}

	public BigDecimal getBusFare() {
		return busFare;
	}

	public void setBusFare(BigDecimal busFare) {
		this.busFare = busFare;
	}

	public BigDecimal getOtherFare() {
		return otherFare;
	}

	public void setOtherFare(BigDecimal otherFare) {
		this.otherFare = otherFare;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	public BigDecimal getTaxiFare() {
		return taxiFare;
	}

	public void setTaxiFare(BigDecimal taxiFare) {
		this.taxiFare = taxiFare;
	}

	public BigDecimal getHotelFare() {
		return hotelFare;
	}

	public void setHotelFare(BigDecimal hotelFare) {
		this.hotelFare = hotelFare;
	}

	public String getDivision() {
		return division;
	}

	public void setDivision(String division) {
		this.division = division;
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
		buffer.append("Traffic regular[");
		buffer.append(" comCode = ").append(comCode);
		buffer.append(" empNo = ").append(empNo);
		buffer.append(" departurePoint = ").append(departurePoint);
		buffer.append(" arrivalPoint = ").append(arrivalPoint);
		buffer.append(" yyyymm = ").append(yyyymm);
		buffer.append(" yyyymmdd = ").append(yyyymmdd);
		buffer.append(" trainFare = ").append(trainFare);
		buffer.append(" busFare = ").append(busFare);
		buffer.append(" otherFare = ").append(otherFare);
		buffer.append(" note = ").append(note);
		buffer.append(" taxiFare = ").append(taxiFare);
		buffer.append(" hotelFare = ").append(hotelFare);
		buffer.append(" division = ").append(division);
		buffer.append(" updateId = ").append(updateId);
		buffer.append(" updateDate = ").append(updateDate);
		buffer.append("]");
		return buffer.toString();
	}
}
