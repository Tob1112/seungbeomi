package com.prms.exception;

public class PrmsException extends RuntimeException {

	public PrmsException(Exception exception) {
		super(exception);
	}

	public PrmsException(String message) {
		super(message);
	}

	public PrmsException(String message, Exception exception) {
		super(message, exception);
	}

}
