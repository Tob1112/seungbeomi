package org.flora.exception;

public class FloraException extends RuntimeException {

	public FloraException (Exception e) {
		super(e);
	}

	public FloraException (String message) {
		super(message);
	}

}
