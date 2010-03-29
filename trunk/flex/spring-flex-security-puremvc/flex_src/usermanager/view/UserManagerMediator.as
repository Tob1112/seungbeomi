package usermanager.view
{
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;

	import usermanager.ApplicationFacade;
	import usermanager.model.UserManagerProxy;
	import usermanager.view.components.UserManagerPanel;

	public class UserManagerMediator extends Mediator implements IMediator
	{
		public static const NAME: String = "UserManagerMediator";

		private var _userManagerProxy:UserManagerProxy;

		/**
		 * constructor
		 * */
		public function UserManagerMediator(viewComponet:Object)
		{

		}


		/**
		 * listNotificationInterests
		 * */
		override public function listNotificationInterests():Array
		{
			return [

			];
		}

		/**
		 * handleNotification
		 * */
		override public function handleNotification(notification:INotification):void
		{
			switch ( notification.getName() )
			{
				case ApplicationFacade.LOGIN:

				break;
				default:
			}
		}

		/**
		 * return viewComponent
		 * */
		protected function get userManagerPanel():UserManagerPanel
		{
			return viewComponent as UserManagerPanel;
		}

	}
}