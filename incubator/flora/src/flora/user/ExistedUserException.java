package flora.user;

import org.springframework.core.ErrorCoded;

public class ExistedUserException extends Exception implements ErrorCoded{

    public ExistedUserException() {
        super();
    }

    public ExistedUserException(String message, Throwable cause) {
        super(message, cause);
    }

    public ExistedUserException(String message) {
        super(message);
    }

    public ExistedUserException(Throwable cause) {
        super(cause);
    }

	public String getErrorCode() {
		return "user.existed.exception";
	}
}
