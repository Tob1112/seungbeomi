package flora.common.exception;

/**
 * base class of all Flora exception classes.
 */
public class FloraException extends RuntimeException{

	private static final long serialVersionUID = 1L;
	
	public FloraException(Exception e) {
		super(e);
	}
	
	public FloraException(String message){
		super(message);
	}

}
