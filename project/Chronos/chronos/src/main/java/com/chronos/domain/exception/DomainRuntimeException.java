package com.chronos.domain.exception;

public class DomainRuntimeException extends RuntimeException{

	private static final long serialVersionUID = 1L;

	public DomainRuntimeException() {
		super();
	}

	public DomainRuntimeException(String message) {
		super(message);
	}

	public DomainRuntimeException(Throwable cause) {
		super(cause);
	}

	public DomainRuntimeException(String message, Throwable cause) {
		super(message, cause);
	}

	public DomainRuntimeException(String messageId, String message) {
		super(messageId + " : " + message);
	}

	public DomainRuntimeException(String messageId, String message, Throwable cause) {
		super(messageId + " : " + message, cause);
	}

}
