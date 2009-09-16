package sample.view
{
    import flash.events.Event;

    import mx.controls.Alert;

    import org.puremvc.as3.interfaces.*;
    import org.puremvc.as3.patterns.mediator.Mediator;

    import sample.ApplicationFacade;
    import sample.model.UserProxy;
    import sample.model.vo.User;
    import sample.view.components.AfterPanel;
    import sample.view.components.BeforePanel;

    public class BeforeMediator extends Mediator implements IMediator
    {
        public static const NAME:String = "BeforeMediator";

		private var userProxy:UserProxy;

        public function BeforeMediator( viewComponent:Object )
        {
            super( NAME, viewComponent );

            userProxy = UserProxy(facade.retrieveProxy(UserProxy.NAME));
            beforePanel.addEventListener(BeforePanel.LOGIN, login);
        }

        private function login(event:Event = null):void {

        	var user:User = userProxy.login(beforePanel.username.text, beforePanel.password.text) as User;
        	if(user == null) Alert.show("user is null");

        	sendNotification(ApplicationFacade.LOGIN_RESULT, user);
        }

        private function get beforePanel():BeforePanel {
        	return viewComponent as BeforePanel;
        }
    }
}
