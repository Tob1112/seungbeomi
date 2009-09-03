package seungbeomi.view
{

	import mx.core.Container;

	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;

	import seungbeomi.model.ApplicationProxy;
	import seungbeomi.model.LoginProxy;
	import seungbeomi.model.UserManagerProxy;

	/**
	 * A Mediator for interacting with the top level Application.
	 */
	public class ApplicationMediator extends Mediator implements IMediator
	{
		public static const NAME:String = 'ApplicationMediator';

		private var _appProxy: ApplicationProxy;
		private var _loginProxy: LoginProxy;
		private var _userManagerProxy: UserManagerProxy;

		/**
		 * Constructor.
		 *
		 * @param object the viewComponent
		 */
		public function ApplicationMediator( viewComponent: Main4PureMVC )
		{
			super(NAME, viewComponent);

			// register the needed mediators for its child components
			facade.registerMediator(new LoginPanelMediator(app.login));
			facade.registerMediator(new LoggedInBoxMediator(app.loggedIn));
			facade.registerMediator(new UserManagerMediator(app.userManager));

			// local reference to the proxies
			_appProxy = facade.retrieveProxy(ApplicationProxy.NAME) as ApplicationProxy;
			_loginProxy = facade.retrieveProxy(LoginProxy.NAME) as LoginProxy;
			_userManagerProxy = facade.retrieveProxy(UserManagerProxy.NAME) as UserManagerProxy;

			// initialize the view state
			_appProxy.viewState = ApplicationProxy.LOGIN_STATE;
		}

		/**
		 * List all notifications this Mediator is interested in.
		 *
		 * @return Array the list of Nofitication names
		 */
		override public function listNotificationInterests():Array
		{

			return [
						ApplicationProxy.VIEW_STATE_CHANGED
					];
		}

		/**
		 * Handle all notifications this Mediator is interested in.
		 *
		 * @param INotification a notification
		 */
		override public function handleNotification( notification:INotification ):void
		{
			switch (notification.getName())
			{
				case ApplicationProxy.VIEW_STATE_CHANGED:
					changeViewState();
				break;
				default:

			}
		}

		/**
		 * Handles the applications view state based on the workflow state defined in Application Proxy
		 */
		private function changeViewState():void
		{
			var child: Container;

			switch (_appProxy.viewState)
			{
				case ApplicationProxy.LOGIN_STATE:
					child = app.login;
				break;
				case ApplicationProxy.LOGIN_ERROR_STATE:
					showError();
					child = app.login;
				break;
				case ApplicationProxy.LOGGED_IN_STATE:
					child = app.loggedIn;
				break;
				case ApplicationProxy.USER_MANAGER_STATE:
					child = app.userManager;
				break;
				default:
					child = app.login;
			}

			app.appView.selectedChild = child;
		}

		/**
		 * Shows an error effect on app
		 * @param message
		 */
	   private function showError():void
	   {
	   		app.faultEffect.end();
	   		app.faultEffect.play();

			// set the view state back to the login state
			_appProxy.viewState = ApplicationProxy.LOGIN_STATE;

	   }

		/**
		 * Cast the viewComponent to its actual type.
		 *
		 * @return app the viewComponent cast to Login
		 */
		protected function get app(): Main4PureMVC
		{
			return viewComponent as Main4PureMVC;
		}
	}
}