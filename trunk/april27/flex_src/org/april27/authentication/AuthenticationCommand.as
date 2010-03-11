package org.april27.authentication {

	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;

	import mx.managers.CursorManager;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;

	import org.april27.employee.EmployeeView;
	import org.april27.model.AuthorizationData;
	import org.april27.model.locator.AuthorizationDataModelLocator;
	import org.april27.util.AlertMessage;

	public class AuthenticationCommand implements ICommand {

		private var view:AuthenticationForm;
		private var model:AuthorizationDataModelLocator = AuthorizationDataModelLocator.getInstance();

		public function execute(e:CairngormEvent):void {
            view = AuthenticationEvent(e).view;
            var responder:Responder = null;
            var delegate:AuthenticationDelegate = null;

            switch (e.type) {
            case AuthenticationEvent.AUTHENTICATE_USER:       // authentication
                responder = new Responder(authenticateUserResultHandler, authenticateUserFaultHandler);
                delegate = new AuthenticationDelegate(responder);
                delegate.authenticateUser(model.authorizationData);
                break;
            }
		}
        // -----------------------------------------------------------
        // authentication
        // -----------------------------------------------------------
        private function authenticateUserResultHandler(e:ResultEvent):void {
            model.authorizationData = AuthorizationData(e.result);
            CursorManager.removeBusyCursor();
            view.removeAllChildren();

			trace ("<<< " + view.parentApplication.april27Views.selectedChild);
            //switch (view.parentApplication.april27Views.selectedChild) {
            //case "employeeView":
            //	var eView:EmployeeView = new EmployeeView();

//            	eView.crea
            	view.parentApplication.april27Views.selectedChild.handler.initComponent();
            //	break;
            //}
            //view.loginButton.enabled = true;
            //AlertMessage.info("login success!!");
        }

        private function authenticateUserFaultHandler(e:FaultEvent):void {
            CursorManager.removeBusyCursor();
            view.authenticationMessage.text = "problem while authentication...";
            trace(e.fault.toString());
            view.authenticationMessage.visible = true;
            view.loginButton.enabled = true;
            AlertMessage.warn(e.fault.faultString);
        }
	}
}