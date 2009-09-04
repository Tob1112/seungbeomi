package usermanager.view
{
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;

	import usermanager.ApplicationFacade;
	import usermanager.model.LoginProxy;
	import usermanager.model.UserManagerProxy;

	public class ApplicationMediator extends Mediator implements IMediator
	{
		public static const NAME: String = "ApplicationMediator";

		private var _loginProxy: LoginProxy;
		private var _userManagerProxy: UserManagerProxy;

		// application view stack
		public static const LOGIN_STACK: uint = 0;
		public static const USER_MANAGER_STACK: uint = 1;

		public function ApplicationMediator(viewComponent: Object)
		{
			super(NAME,viewComponent);

			// register mediator
			facade.registerMediator(new LoginMediator(app.loginPanel));
			facade.registerMediator(new UserManagerMediator(app.userManagerPanel));

			// register proxy
			_loginProxy = LoginProxy(facade.retrieveProxy(LoginProxy.NAME));
			_userManagerProxy = UserManagerProxy(facade.retrieveProxy(UserManagerProxy.NAME));

		}



		override public function listNotificationInterests():Array
		{
			return [
				ApplicationFacade.LOGIN,
				ApplicationFacade.LOGOUT,
				ApplicationFacade.LOGIN_ERROR
			];
		}

		override public function handleNotification(notification:INotification):void
		{
			switch ( notification.getName() )
			{
				case ApplicationFacade.LOGIN:

				break;
				case ApplicationFacade.LOGIN_ERROR:
					showError();
				break;
				default:

			}
		}

		private function showError():void
	   {
	   		app.faultEffect.end();
	   		app.faultEffect.play();

			app.viewStack.selectedIndex = LOGIN_STACK;

	   }


		protected function get app():UserManager
		{
			return viewComponent as UserManager;
		}

	}
}