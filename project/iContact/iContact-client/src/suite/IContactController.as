package suite {
    import com.adobe.cairngorm.control.FrontController;

    import suite.icontact.IContactCommand;
    import suite.icontact.IContactEvent;

    public class IContactController extends FrontController {

        public function IContactController() {
            super();

            addCommand(IContactEvent.LOGIN, IContactCommand);

        }
    }
}

