package org.april.exception;

public class AprilException extends RuntimeException {

	private static final long serialVersionUID = 1L;

	public AprilException(Exception e) {
		super(e);
	}

	public AprilException(String message) {
		super(message);
	}

}