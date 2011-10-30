package auction.command;

import org.springframework.transaction.annotation.Transactional;

//import javax.ejb.ApplicationException;

/**
 * A checked exception thrown by command execute methods, wrapping the root
 * cause.
 * 
 * @author Christian Bauer
 */
// @ApplicationException(rollback = true)
@Transactional(rollbackFor = { Exception.class })
public class CommandException extends Exception {

	public CommandException() {
	}

	public CommandException(String message) {
		super(message);
	}

	public CommandException(String message, Throwable cause) {
		super(message, cause);
	}

	public CommandException(Throwable cause) {
		super(cause);
	}
}
