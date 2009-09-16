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

    public class AfterMediator extends Mediator implements IMediator
    {
        public static const NAME:String = "AfterMediator";

        public static const SHOW_AFTER_DATA:String = "showAfterData";

		private var userProxy:UserProxy;

        public function AfterMediator( viewComponent:Object )
        {
            super( NAME, viewComponent );

            userProxy = UserProxy(facade.retrieveProxy(UserProxy.NAME));
        }

		override public function listNotificationInterests():Array {
			return [
				AfterMediator.SHOW_AFTER_DATA
			];
		}

		override public function handleNotification(note:INotification):void {
			switch(note.getName()) {
				case  AfterMediator.SHOW_AFTER_DATA:
					var user:User = note.getBody() as User;
					trace(user.username + ", " + user.password);
					afterPanel.lblUser.text = user.username;
					break;
			}
		}

         private function get afterPanel():AfterPanel {
        	return viewComponent as AfterPanel;
        }
    }
}
