package suite.icontact {
    import com.adobe.cairngorm.commands.ICommand;
    import com.adobe.cairngorm.control.CairngormEvent;

    import mx.controls.Alert;
    import mx.rpc.Responder;
    import mx.rpc.events.FaultEvent;
    import mx.rpc.events.ResultEvent;

    import suite.Constants;
    import suite.common.IContactDaoEvent;

    public class IContactCommand implements ICommand {

        private var model:IContactModelLocator = IContactModelLocator.getInstance();
        private var view:IContactView;

        public function execute(e:CairngormEvent):void {
            view = IContactEvent(e).view;
            var responder:Responder = null;
            var delegate:IContactDelegate = null;

            switch(e.type) {
                case IContactEvent.LOGIN:
                    responder = new Responder(loginResultHandler, serviceFaultHandler);
                    delegate = new IContactDelegate(responder);
                    delegate.login(model.user);
                    break;
            }
        }

        private function loginResultHandler(e:ResultEvent):void {
			// login 成功時
			var iContactDaoEvent:IContactDaoEvent = new IContactDaoEvent(IContactDaoEvent.OPEN_DATABASE);
			iContactDaoEvent.dispatch();
			view.currentState = Constants.SMALL_STATE;
        }

        private function serviceFaultHandler(e:FaultEvent):void {
            Alert.show(e.fault.toString());
        }
    }
}

