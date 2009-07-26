package flora.user;


import org.springframework.core.ErrorCoded;

public class UserNotFoundException extends Exception implements ErrorCoded {

    public UserNotFoundException() {
        super();
    }

    public UserNotFoundException(String message, Throwable cause) {
        super(message, cause);
    }

    public UserNotFoundException(String message) {
        super(message);
    }

    public UserNotFoundException(Throwable cause) {
        super(cause);
    }

	public String getErrorCode() {
		return "user.notfound.exception";
	}
}
