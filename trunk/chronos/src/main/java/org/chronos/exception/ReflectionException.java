package org.chronos.exception;

public class ReflectionException extends ChronosException{

	private static final long serialVersionUID = 1L;

	public ReflectionException(Exception e) {
		super(e);
	}
}
