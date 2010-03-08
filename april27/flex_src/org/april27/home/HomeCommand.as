package org.april27.home {

    import com.adobe.cairngorm.commands.ICommand;
    import com.adobe.cairngorm.control.CairngormEvent;

    import mx.core.Application;
    import mx.managers.CursorManager;
    import mx.rpc.Responder;
    import mx.rpc.events.FaultEvent;
    import mx.rpc.events.ResultEvent;

    import org.april27.model.locator.EmployeeModelLocator;
    import org.april27.util.AlertMessage;

    public class HomeCommand implements ICommand {

        private var view:HomeView;
        private var model:EmployeeModelLocator = EmployeeModelLocator.getInstance();

        public function execute(e:CairngormEvent):void {
            view = HomeEvent(e).view;
            var responder:Responder = null;
            var delegate:HomeDelegate = null;

            switch (e.type) {
            case HomeEvent.AUTHENTICATE_USER:       // login
                responder = new Responder(authenticateUserResultHandler, authenticateUserFaultHandler);
                delegate = new HomeDelegate(responder);
                delegate.authenticateUser(model.employee.empName, model.employee.password);
                break;
            }
        }

        // -----------------------------------------------------------
        // login
        // -----------------------------------------------------------
        private function authenticateUserResultHandler(e:ResultEvent):void {
            CursorManager.removeBusyCursor();
            view.loginButton.enabled = true;
            Application.application.initComponent();
        }

        private function authenticateUserFaultHandler(e:FaultEvent):void {
            CursorManager.removeBusyCursor();
            view.authenticationMessage.text = "problem while authentication...";
            //view.authenticationMessage.text = e.fault.toString();
            trace(e.fault.toString());
            view.authenticationMessage.visible = true;
            view.loginButton.enabled = true;
            AlertMessage.warn(e.fault.faultString);
        }
    }
}