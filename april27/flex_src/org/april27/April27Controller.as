package org.april27 {

	import com.adobe.cairngorm.control.FrontController;

	import org.april27.security.AuthenticationCommand;
	import org.april27.security.AuthenticationEvent;

    public class April27Controller extends FrontController {

        public function April27Controller() {
        	super();

        	addCommand(AuthenticationEvent.AUTHENTICATE_USER, AuthenticationCommand);	// login
        }
    }
}