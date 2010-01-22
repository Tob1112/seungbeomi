package com.prms.model;

import java.math.BigDecimal;
import java.sql.Date;

public class Traffic {

	/** 会社コード */
	private String comCode;

	/** 社員番号 */
	private String empNo;

	/** 年月 */
	private Date yyyymm;

	/** ステータスコード */
	private String statusCode;

	/** 定期券合計 */
	private BigDecimal trainTotal;

	/** バス代合計 */
	private BigDecimal busTotal;

	/** その他合計 */
	private BigDecimal otherTotal;

	/** 定期合計 */
	private BigDecimal regularTotal;

	/** 非定期 - 通勤分合計 */
	private BigDecimal commutationTotal;

	/** 非定期 - 業務分合計 */
	private BigDecimal affairsTotal;

	/** 非定期合計 */
	private BigDecimal irregularTotal;

	/** 交通費合計 */
	private BigDecimal trafficTotal;

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

	public String getStatusCode() {
		return statusCode;
	}

	public void setStatusCode(String statusCode) {
		this.statusCode = statusCode;
	}

	public BigDecimal getTrainTotal() {
		return trainTotal;
	}

	public void setTrainTotal(BigDecimal trainTotal) {
		this.trainTotal = trainTotal;
	}

	public BigDecimal getBusTotal() {
		return busTotal;
	}

	public void setBusTotal(BigDecimal busTotal) {
		this.busTotal = busTotal;
	}

	public BigDecimal getOtherTotal() {
		return otherTotal;
	}

	public void setOtherTotal(BigDecimal otherTotal) {
		this.otherTotal = otherTotal;
	}

	public BigDecimal getRegularTotal() {
		return regularTotal;
	}

	public void setRegularTotal(BigDecimal regularTotal) {
		this.regularTotal = regularTotal;
	}

	public BigDecimal getCommutationTotal() {
		return commutationTotal;
	}

	public void setCommutationTotal(BigDecimal commutationTotal) {
		this.commutationTotal = commutationTotal;
	}

	public BigDecimal getAffairsTotal() {
		return affairsTotal;
	}

	public void setAffairsTotal(BigDecimal affairsTotal) {
		this.affairsTotal = affairsTotal;
	}

	public BigDecimal getIrregularTotal() {
		return irregularTotal;
	}

	public void setIrregularTotal(BigDecimal irregularTotal) {
		this.irregularTotal = irregularTotal;
	}

	public BigDecimal getTrafficTotal() {
		return trafficTotal;
	}

	public void setTrafficTotal(BigDecimal trafficTotal) {
		this.trafficTotal = trafficTotal;
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
		buffer.append("Traffic[");
		buffer.append(" comCode = ").append(comCode);
		buffer.append(" empNo = ").append(empNo);
		buffer.append(" yyyymm = ").append(yyyymm);
		buffer.append(" statusCode = ").append(statusCode);
		buffer.append(" trainTotal = ").append(trainTotal);
		buffer.append(" busTotal = ").append(busTotal);
		buffer.append(" otherTotal = ").append(otherTotal);
		buffer.append(" regualarTotal = ").append(regularTotal);
		buffer.append(" commutationTotal = ").append(commutationTotal);
		buffer.append(" affairsTotal = ").append(affairsTotal);
		buffer.append(" irregualrTotal = ").append(irregularTotal);
		buffer.append(" trafficTotal = ").append(trafficTotal);
		buffer.append(" updateId = ").append(updateId);
		buffer.append(" updateDate = ").append(updateDate);
		buffer.append("]");
		return buffer.toString();
	}

}
