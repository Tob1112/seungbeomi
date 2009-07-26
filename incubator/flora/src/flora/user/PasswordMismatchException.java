package flora.user;


import org.springframework.core.ErrorCoded;

public class PasswordMismatchException extends Exception implements ErrorCoded {

	public PasswordMismatchException() {
		super();
	}

	public PasswordMismatchException(String message) {
		super(message);
	}

	public PasswordMismatchException(Throwable cause) {
		super(cause);
	}

	public PasswordMismatchException(String message, Throwable cause) {
		super(message, cause);
	}

	public String getErrorCode() {
		return "password.mismatch.exception";
	}
}
