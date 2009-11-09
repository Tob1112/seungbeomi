package flora.business {
    import com.adobe.cairngorm.control.FrontController;

    import flora.business.commands.LoginCommand;
    import flora.events.LoginEvent;

    public class FloraController extends FrontController {

        public function FloraController() {
        	trace("FloraController");
        	super();
        	addCommand(LoginEvent.EVENT_ID, LoginCommand);
        }

    }
}