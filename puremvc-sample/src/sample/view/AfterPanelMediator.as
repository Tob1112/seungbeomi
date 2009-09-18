package sample.view
{
    import org.puremvc.as3.interfaces.*;
    import org.puremvc.as3.patterns.mediator.Mediator;

    import sample.ApplicationFacade;
    import sample.model.UserProxy;
    import sample.model.vo.User;
    import sample.view.components.AfterPanel;

    public class AfterPanelMediator extends Mediator implements IMediator
    {
        public static const NAME:String = "AfterPanelMediator";

		private var userProxy:UserProxy;

        public function AfterPanelMediator( viewComponent:Object )
        {
            super( NAME, viewComponent );

			userProxy = UserProxy(facade.retrieveProxy(UserProxy.NAME));
        }

		override public function listNotificationInterests():Array {
			return [
				ApplicationFacade.LOGIN_RESULT
			];
		}

		override public function handleNotification(note:INotification):void {
			switch(note.getName()) {
				case  ApplicationFacade.LOGIN_RESULT:
					var user:User = userProxy.user;
					trace("<<< AfterPanelMediator " + user.username + ", " + user.password);
					//afterPanel.lblUser.text = user.username;
					break;
			}
		}

         protected function get afterPanel():AfterPanel {
        	return viewComponent as AfterPanel;
        }
    }
}












