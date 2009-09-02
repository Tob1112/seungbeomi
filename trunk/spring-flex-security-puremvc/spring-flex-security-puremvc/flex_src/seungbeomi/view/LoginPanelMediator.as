package seungbeomi.view
{
	import flash.events.Event;

	import seungbeomi.ApplicationFacade;
	import seungbeomi.model.LoginProxy;
	import seungbeomi.model.vo.UserVO;
	import seungbeomi.view.components.LoginPanel;
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;


	/**
	 * A Mediator for interacting with the LoginPanel component.
	 */
	public class LoginPanelMediator extends Mediator implements IMediator
	{

		private var _loginProxy: LoginProxy;

		public static const NAME:String = 'LoginPanelMediator';

		/**
		 * Constructor.
		 * @param object the viewComponent
		 */
		public function LoginPanelMediator(viewComponent: LoginPanel)
		{
			super(NAME, viewComponent);

			// local reference to the LoginProxy
			_loginProxy = facade.retrieveProxy( LoginProxy.NAME ) as LoginProxy;

			// listen to events dispatched by its view component
			loginPanel.addEventListener( LoginPanel.TRY_LOGIN, login );

		}

		/**
		 * The user has initiated to log in.
		 */
		private function login (event: Event = null ): void
		{
			var userVO: UserVO = new UserVO();
			userVO.userId = loginPanel.userId.text;
			userVO.password = loginPanel.password.text;

			sendNotification( ApplicationFacade.LOGIN, userVO );
		}

		/**
		 * List all notifications this Mediator is interested in.
		 *
		 * @return Array the list of Nofitication names
		 */
		override public function listNotificationInterests():Array
		{
			return [
						LoginProxy.LOGIN_FAILED,
						LoginProxy.LOGIN_SUCCESS
					 ];
		}

		/**
		 * Handle all notifications this Mediator is interested in.
		 *
		 * @param INotification a notification
		 */
		override public function handleNotification( notification:INotification ):void
		{
			switch ( notification.getName() )
			{
				case LoginProxy.LOGIN_FAILED:
					loginPanel.statusMessage.htmlText = "<font color='#FF6600'>" + _loginProxy.faultMessage + "</font>";
				break;
				case LoginProxy.LOGIN_SUCCESS:
					loginPanel.statusMessage.htmlText = "";
				break;
				default:

			}
		}

		/**
		 * Cast the viewComponent to its actual type.
		 * @return app the viewComponent cast to LoginPanel
		 */
		protected function get loginPanel(): LoginPanel
		{
			return viewComponent as LoginPanel;
		}
	}
}