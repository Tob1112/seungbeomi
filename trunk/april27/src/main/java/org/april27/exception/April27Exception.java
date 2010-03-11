package org.april27.exception;

public class April27Exception extends RuntimeException {

	private static final long serialVersionUID = 1L;

	public April27Exception(Exception e) {
		super(e);
	}

	public April27Exception(String message) {
		super(message);
	}

}