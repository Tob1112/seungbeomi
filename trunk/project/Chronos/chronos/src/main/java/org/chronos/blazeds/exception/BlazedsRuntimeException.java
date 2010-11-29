package org.chronos.blazeds.exception;

public class BlazedsRuntimeException extends RuntimeException{

	private static final long serialVersionUID = 1L;

	public BlazedsRuntimeException() {
		super();
	}

	public BlazedsRuntimeException(String message) {
		super(message);
	}

	public BlazedsRuntimeException(Throwable cause) {
		super(cause);
	}

	public BlazedsRuntimeException(String message, Throwable cause) {
		super(message, cause);
	}

	public BlazedsRuntimeException(String messageId, String message) {
		super(messageId + " : " + message);
	}

	public BlazedsRuntimeException(String messageId, String message, Throwable cause) {
		super(messageId + " : " + message, cause);
	}

}
