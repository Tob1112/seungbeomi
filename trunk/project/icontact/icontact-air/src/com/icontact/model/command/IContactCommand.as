package com.icontact.model.command {

    import com.adobe.cairngorm.commands.ICommand;
    import com.adobe.cairngorm.control.CairngormEvent;
    import com.icontact.Constants;
    import com.icontact.model.IContactModelLocator;
    import com.icontact.model.delegate.IContactDelegate;
    import com.icontact.model.domain.Contact;
    import com.icontact.model.event.IContactEvent;
    import com.icontact.view.IContactForm;
    import com.icontact.view.IContactView;

    import flash.events.TimerEvent;
    import flash.utils.Timer;

    import mx.controls.Alert;
    import mx.rpc.Responder;
    import mx.rpc.events.FaultEvent;
    import mx.rpc.events.ResultEvent;

    public class IContactCommand implements ICommand {

        private var model:IContactModelLocator = IContactModelLocator.getInstance();
        private var view:IContactView;
        private var formView:IContactForm;
        private var contact:Contact;

        public function execute(e:CairngormEvent):void {
            var responder:Responder = null;
            var delegate:IContactDelegate = null;

            switch(e.type) {
                case IContactEvent.LOGIN:
		            view = IContactEvent(e).view as IContactView;
                    responder = new Responder(loginResultHandler, serviceFaultHandler);
                    delegate = new IContactDelegate(responder);
                    delegate.login(model.user);
                    break;
            }
        }

        private function loginResultHandler(e:ResultEvent):void {
        	Alert.show(e.result.toString());

        	// start sync
        	IContactModelLocator.syncTimer.start();
        }

        private function serviceFaultHandler(e:FaultEvent):void {
            Alert.show(e.fault.toString());
        }
    }
}

