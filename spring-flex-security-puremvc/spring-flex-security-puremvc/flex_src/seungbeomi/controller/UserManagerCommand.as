package seungbeomi.controller
{
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;

	import seungbeomi.model.UserManagerProxy;

	public class UserManagerCommand extends SimpleCommand
	{
		override public function execute(notification: INotification):void
		{
			var userManagerProxy:UserManagerProxy = facade.retrieveProxy(UserManagerProxy.NAME) as UserManagerProxy;
			userManagerProxy.findUsers();
		}
	}
}