package com.icontact.common.message;

import static org.junit.Assert.*;
import static org.hamcrest.CoreMatchers.*;

import org.junit.Before;
import org.junit.Test;

import com.icontact.common.exception.IContactRuntimeException;

public class IContactMessagesTest {

	@Before
	public void setUp() {

	}

	@Test(expected=IContactRuntimeException.class)
	public void testMessage() {
		String messageId;
		String message;

		messageId = MessageIds.SQL_EXCEPTION;
		message = IContactMessages.getMessage(messageId);

		assertThat(messageId, is("IC90001"));
		assertThat(message, is("SQL error"));

		throw new IContactRuntimeException(messageId, message);
	}
}
