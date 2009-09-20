package sample.view
{
    import mx.events.FlexEvent;

    import org.puremvc.as3.interfaces.*;
    import org.puremvc.as3.patterns.mediator.Mediator;

    import sample.model.UserProxy;
    import sample.model.vo.User;
    import sample.view.components.LoginResultPanel;

    public class LoginResultPanelMediator extends Mediator implements IMediator
    {
        public static const NAME:String = "AfterPanelMediator";

		private var userProxy:UserProxy;

        public function LoginResultPanelMediator( viewComponent:Object )
        {
            super( NAME, viewComponent );

			userProxy = UserProxy(facade.retrieveProxy(UserProxy.NAME));
			afterPanel.addEventListener(FlexEvent.CREATION_COMPLETE, onComplete);
        }

		private function onComplete(event:FlexEvent):void {
			var user:User = userProxy.user;
			afterPanel.lblLoginResult.text = "username : " + user.username + ", password : " + user.password;
		}

         protected function get afterPanel():LoginResultPanel {
        	return viewComponent as LoginResultPanel;
        }
    }
}












