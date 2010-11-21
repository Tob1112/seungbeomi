package com.chronos.common.messages;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.MessageSourceAccessor;

public class Messages {

	@Autowired
	private static MessageSourceAccessor messageSource;

	public static String getMessages (String messageId) {
		return messageSource.getMessage(messageId);
	}
}
