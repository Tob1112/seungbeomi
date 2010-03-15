package org.chronos {

	import com.adobe.cairngorm.control.FrontController;

	import org.chronos.authentication.AuthenticationCommand;
	import org.chronos.authentication.AuthenticationEvent;

    public class ChronosController extends FrontController {

        public function ChronosController() {
        	super();

        	addCommand(AuthenticationEvent.AUTHENTICATE_USER, AuthenticationCommand);	// login
        }
    }
}