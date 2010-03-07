package org.april27 {

	import com.adobe.cairngorm.control.FrontController;

	import org.april27.home.HomeCommand;
	import org.april27.home.HomeEvent;

    public class April27Controller extends FrontController {

        public function April27Controller() {
        	super();

        	addCommand(HomeEvent.AUTHENTICATE_USER, HomeCommand);
        }
    }
}