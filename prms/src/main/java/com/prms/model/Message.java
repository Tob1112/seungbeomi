package com.prms.model;

/**
 * メッセージクラス
 *
 * @author 孫承範
 */
public class Message {

	/** メッセージ区分 */
	private String msgType;

	/** メッセージID */
	private String msgId;

	/** メッセージ */
	private String msgBody;

	/**
	 * コンストラクター
	 *
	 * @param msgType
	 *            メッセージ区分
	 * @param msgNo
	 *            メッセージID
	 */
	public Message(String msgType, String msgNo) {
		this.msgType = msgType;
		this.msgId = msgNo;
	}

	/**
	 * コンストラクター
	 *
	 * @param msgType
	 *            メッセージ区分
	 * @param msgNo
	 *            メッセージID
	 * @param msgBody
	 *            メッセージ
	 */
	public Message(String msgType, String msgNo, String msgBody) {
		this.msgType = msgType;
		this.msgId = msgNo;
		this.msgBody = msgBody;
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

	public String getMsgBody() {
		return msgBody;
	}

	public void setMsgBody(String msgBody) {
		this.msgBody = msgBody;
	}

	public String toString() {
		StringBuffer buffer = new StringBuffer();
		buffer.append("Message[");
		buffer.append(" msgType = ").append(msgType);
		buffer.append(" msgNo = ").append(msgId);
		buffer.append(" msgBody = ").append(msgBody);
		buffer.append("]");
		return buffer.toString();
	}
}
