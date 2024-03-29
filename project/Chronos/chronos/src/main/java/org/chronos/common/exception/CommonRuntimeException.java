package org.chronos.common.exception;

public class CommonRuntimeException extends RuntimeException{

	private static final long serialVersionUID = 1L;

	public CommonRuntimeException() {
		super();
	}

	public CommonRuntimeException(String message) {
		super(message);
	}

	public CommonRuntimeException(Throwable cause) {
		super(cause);
	}

	public CommonRuntimeException(String message, Throwable cause) {
		super(message, cause);
	}

	public CommonRuntimeException(String messageId, String message) {
		super(messageId + " : " + message);
	}

	public CommonRuntimeException(String messageId, String message, Throwable cause) {
		super(messageId + " : " + message, cause);
	}

}
