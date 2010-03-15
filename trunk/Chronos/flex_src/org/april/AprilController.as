package org.april {

	import com.adobe.cairngorm.control.FrontController;

	import org.april.authentication.AuthenticationCommand;
	import org.april.authentication.AuthenticationEvent;

    public class AprilController extends FrontController {

        public function AprilController() {
        	super();

        	addCommand(AuthenticationEvent.AUTHENTICATE_USER, AuthenticationCommand);	// login
        }
    }
}