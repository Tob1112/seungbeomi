package com.leinbow.message;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.MessageSourceAccessor;

public final class LeinbowMessages {

	@Autowired
	private static MessageSourceAccessor messageSourceAccessor;

	/**
	 * コンストラクターです。
	 * @param messageSourceAccessor
	 */
	public LeinbowMessages(MessageSourceAccessor messageSourceAccessor) {
		LeinbowMessages.messageSourceAccessor = messageSourceAccessor;
	}

	/**
	 * メッセージを取得する
	 * @param messageId messageId
	 * @return message
	 */
	public static String getMessage(String messageId) {
		return messageSourceAccessor.getMessage(messageId);
	}

	/**
	 * メッセージを取得する
	 * @param messageId messageId
	 * @param args
	 * @return message
	 */
	public static String getMessage(String messageId, Object... args) {
		List<Object> params = new ArrayList<Object>();

		if (args == null) {
			return LeinbowMessages.getMessage(messageId);
		}

		for (Object o : args) {
			params.add(o);
		}

		return messageSourceAccessor.getMessage(messageId, params.toArray());
	}

}
