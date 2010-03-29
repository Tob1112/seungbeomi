package seungbeomi.controller
{
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;

	import seungbeomi.model.LoginProxy;
	import seungbeomi.model.vo.UserVO;

	public class LoginCommand extends SimpleCommand
	{
		/**
		 * Listens to the login notification retrieving the LoginProxy and does login
		 * */
		 override public function execute(notification:INotification):void
		 {
		 	var userVO: UserVO = notification.getBody() as UserVO;
		 	var loginProxy:LoginProxy = facade.retrieveProxy(LoginProxy.NAME) as LoginProxy;
		 	loginProxy.login(userVO);
		 }
	}
}