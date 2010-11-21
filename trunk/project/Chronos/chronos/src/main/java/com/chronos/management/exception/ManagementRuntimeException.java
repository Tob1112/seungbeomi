package com.chronos.management.exception;

public class ManagementRuntimeException extends RuntimeException{

	private static final long serialVersionUID = 1L;

	public ManagementRuntimeException() {
		super();
	}

	public ManagementRuntimeException(String message) {
		super(message);
	}

	public ManagementRuntimeException(Throwable cause) {
		super(cause);
	}

	public ManagementRuntimeException(String message, Throwable cause) {
		super(message, cause);
	}

	public ManagementRuntimeException(String messageId, String message) {
		super(messageId + " : " + message);
	}

	public ManagementRuntimeException(String messageId, String message, Throwable cause) {
		super(messageId + " : " + message, cause);
	}

}
