package sample.view
{
    import flash.events.Event;

    import mx.controls.Alert;

    import org.puremvc.as3.interfaces.*;
    import org.puremvc.as3.patterns.mediator.Mediator;

    import sample.ApplicationFacade;
    import sample.model.UserProxy;
    import sample.view.components.LoginPanel;

    public class LoginPanelMediator extends Mediator implements IMediator
    {
        public static const NAME:String = "LoginPanelMediator";

		private var userProxy:UserProxy;

        public function LoginPanelMediator( viewComponent:Object )
        {
            super( NAME, viewComponent );

            userProxy = UserProxy(facade.retrieveProxy(UserProxy.NAME));
            loginPanel.addEventListener(LoginPanel.LOGIN, login);
        }

        private function login(event:Event = null):void {

        	userProxy.login(loginPanel.username.text, loginPanel.password.text);
	        sendNotification(ApplicationFacade.VIEW_LOGIN_RESULT_PANEL);
        }

        private function get loginPanel():LoginPanel {
        	return viewComponent as LoginPanel;
        }
    }
}
