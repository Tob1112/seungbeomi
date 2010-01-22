package com.prms.model;

import java.sql.Date;

public class CodeDetail {

	/** コード区分 */
	private String codeType;

	/** コード詳細 */
	private String codeDetail;

	/** 登録日 */
	private Date regDay;

	/** 削除日 */
	private Date delDay;

	/** 最新フラグ */
	private String latestFlag;

	/** コード名 */
	private String codeDetailName;

	public CodeDetail(){}

	public CodeDetail(String codeType, String codeDetail){
		this.codeType = codeType;
		this.codeDetail = codeDetail;
	}

	public String getCodeType() {
		return codeType;
	}
	public void setCodeType(String codeType) {
		this.codeType = codeType;
	}
	public String getCodeDetail() {
		return codeDetail;
	}
	public void setCodeDetail(String codeDetail) {
		this.codeDetail = codeDetail;
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
	public String getCodeDetailName() {
		return codeDetailName;
	}
	public void setCodeDetailName(String codeDetailName) {
		this.codeDetailName = codeDetailName;
	}

	public String toString(){
		StringBuffer buffer = new StringBuffer();

		buffer.append("CodeDetail[");
		buffer.append(" codeType = ").append(codeType);
		buffer.append(" codeDetail = ").append(codeDetail);
		buffer.append(" regDay = ").append(regDay);
		buffer.append(" delDay = ").append(delDay);
		buffer.append(" latestFlag = ").append(latestFlag);
		buffer.append(" codeDetailName = ").append(codeDetailName);
		buffer.append("]");

		return buffer.toString();
	}

}
