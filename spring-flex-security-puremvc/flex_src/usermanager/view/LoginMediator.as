package usermanager.view
{
	import flash.events.Event;
	import mx.controls.Alert;

	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;

	import usermanager.ApplicationFacade;
	import usermanager.model.vo.UserVO;
	import usermanager.model.LoginProxy;
	import usermanager.view.components.LoginPanel;

	public class LoginMediator extends Mediator implements IMediator
	{
		public static const NAME: String = "LoginMediator";

		private var _loginProxy: LoginProxy;

		/**
		 * constructor
		 * */
		public function LoginMediator(viewComponet:Object)
		{
			super(NAME, viewComponet);

			_loginProxy = LoginProxy(facade.retrieveProxy(LoginProxy.NAME));

			loginPanel.addEventListener(LoginPanel.LOGIN, login);
		}

		private function login(event:Event = null):void
		{
			// execute login method of LoginProxy
			var userVO:UserVO = _loginProxy.login(loginPanel.userId.text, loginPanel.password.text) as UserVO;
			if (userVO != null)
			{
				//trace("logined userid = " + userVO.userId + ", roles = " + userVO.groups);
				sendNotification(ApplicationFacade.VIEW_USERMANAGER);
			}
			else
			{
				Alert.show("invalide userid and/or password!!", "LOGIN FAILED");
			}
		}

		/**
		 * listNotificationInterests
		 * */
		override public function listNotificationInterests():Array
		{
			return [
				ApplicationFacade.LOGOUT
			];
		}

		/**
		 * handleNotification
		 * */
		override public function handleNotification(notification:INotification):void
		{
			switch (notification.getName())
			{
				case ApplicationFacade.LOGIN:
					loginPanel.resetLogin();
				break;
			}
		}

		/**
		 * return viewComponet
		 * */
		protected function get loginPanel(): LoginPanel
		{
			return viewComponent as LoginPanel;
		}

	}
}