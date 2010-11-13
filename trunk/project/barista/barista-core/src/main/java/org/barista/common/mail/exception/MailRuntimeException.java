package org.barista.common.mail.exception;

public class MailRuntimeException extends RuntimeException{

	public MailRuntimeException() {
		super();
	}

	public MailRuntimeException(String message) {
		super(message);
	}

	public MailRuntimeException(String message, Throwable cause) {
		super(message, cause);
	}

	public MailRuntimeException(Throwable cause) {
		super(cause);
	}

	public MailRuntimeException(String messageId, String message) {
		super(messageId + " : " + message);
	}

}
