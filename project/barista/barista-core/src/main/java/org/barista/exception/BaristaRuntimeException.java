package org.barista.exception;

public class BaristaRuntimeException extends RuntimeException{

	private static final long serialVersionUID = 1L;

	public BaristaRuntimeException() {
		super();
	}

	public BaristaRuntimeException(String message) {
		super(message);
	}

	public BaristaRuntimeException(Throwable cause) {
		super(cause);
	}

	public BaristaRuntimeException(String message, Throwable cause) {
		super(message, cause);
	}

	public BaristaRuntimeException(String messageId, String message) {
		super(messageId + " : " + message);
	}

	public BaristaRuntimeException(String messageId, String message, Throwable cause) {
		super(messageId + " : " + message, cause);
	}

}
