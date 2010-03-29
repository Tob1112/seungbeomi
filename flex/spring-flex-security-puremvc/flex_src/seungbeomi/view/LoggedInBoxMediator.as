package seungbeomi.view
{
	import seungbeomi.model.LoginProxy;
	import seungbeomi.view.components.LoggedInBox;
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;

	/**
	 * A Mediator for interacting with the LoggedInBox component.
	 */
	public class LoggedInBoxMediator extends Mediator implements IMediator
	{

		private var _loginProxy: LoginProxy;

		public static const NAME:String = 'LoggedInBoxMediator';

		/**
		 * Constructor.
		 * @param object the viewComponent
		 */
		public function LoggedInBoxMediator(viewComponent: LoggedInBox)
		{
			super(NAME, viewComponent);
			//
			// local reference to the login proxy
			_loginProxy = facade.retrieveProxy(LoginProxy.NAME) as LoginProxy;

		}

		/**
		 * List all notifications this Mediator is interested in.
		 *
		 * @return Array the list of Nofitication names
		 */
		override public function listNotificationInterests():Array
		{
			return [ LoginProxy.LOGIN_SUCCESS ];
		}

		/**
		 * Handle all notifications this Mediator is interested in.
		 *
		 * @param INotification a notification
		 */
		override public function handleNotification( notification: INotification ):void
		{
			switch ( notification.getName() )
			{
				case LoginProxy.LOGIN_SUCCESS:
					loggedInBox.userVO = _loginProxy.userVO;
				break;
				default:

			}
		}

		/**
		 * Cast the viewComponent to its actual type.
		 *
		 * @return app the viewComponent cast to LoggedInBox
		 */
		protected function get loggedInBox(): LoggedInBox
		{
			return viewComponent as LoggedInBox;
		}
	}
}