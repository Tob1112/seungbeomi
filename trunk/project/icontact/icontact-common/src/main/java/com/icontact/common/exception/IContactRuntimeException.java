package com.icontact.common.exception;

public class IContactRuntimeException extends RuntimeException{

	public IContactRuntimeException() {
		super();
	}

	public IContactRuntimeException(String message) {
		super(message);
	}

	public IContactRuntimeException(String message, Throwable cause) {
		super(message, cause);
	}

	public IContactRuntimeException(Throwable cause) {
		super(cause);
	}

	public IContactRuntimeException(String messageId, String message) {
		super(messageId + " : " + message);
	}

}
