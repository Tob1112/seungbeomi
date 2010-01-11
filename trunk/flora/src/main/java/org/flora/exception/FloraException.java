package org.flora.exception;

public class FloraException extends RuntimeException {

	public FloraException (Exception exception) {
		super(exception);
	}

	public FloraException (String message) {
		super(message);
	}

	public FloraException (String message, Exception exception) {
		super(message, exception);
	}

}
