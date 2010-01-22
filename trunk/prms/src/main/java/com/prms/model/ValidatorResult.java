package com.prms.model;

/**
 * Validator結果返却用クラス
 *
 * @author 久場
 */
public class ValidatorResult {

	/** メッセージ区分 */
	private String msgType;

	/** メッセージID */
	private String msgId;

	/** エラー箇所 */
	private String errorLocation;

	/**
	 * コンストラクタ
	 *
	 * @param msgType
	 *            メッセージ区分
	 * @param msgId
	 *            メッセージID
	 * @param errorLocation
	 *            エラー箇所
	 */
	public ValidatorResult(String msgType, String msgId, String errorLocation) {
		this.msgType = msgType;
		this.msgId = msgId;
		this.errorLocation = errorLocation;
	}

	public String getMsgType() {
		return msgType;
	}

	public void setMsgType(String msgType) {
		this.msgType = msgType;
	}

	public String getMsgId() {
		return msgId;
	}

	public void setMsgId(String msgId) {
		this.msgId = msgId;
	}

	public String getErrorLocation() {
		return errorLocation;
	}

	public void setErrorLocation(String errorLocation) {
		this.errorLocation = errorLocation;
	}

	/**
	 *
	 * @return
	 * @author
	 */
	public String toString() {
		StringBuffer buffer = new StringBuffer();
		buffer.append("ValidatorResult[");
		buffer.append("]");
		return buffer.toString();
	}
}
