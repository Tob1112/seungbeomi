package org.chronos.exception;

public class ChronosException extends RuntimeException {

	private static final long serialVersionUID = 1L;

	public ChronosException(Exception e) {
		super(e);
	}

	public ChronosException(String message) {
		super(message);
	}

}