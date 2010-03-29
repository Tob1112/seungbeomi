package seungbeomi.controller
{
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;

	import seungbeomi.model.UserManagerProxy;
	import seungbeomi.view.ApplicationMediator;

	public class ViewPrepCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void
		{
			facade.registerMediator(new ApplicationMediator(notification.getBody() as Main4PureMVC));

			var userManagerProxy: UserManagerProxy = facade.retrieveProxy(UserManagerProxy.NAME) as UserManagerProxy;
			userManagerProxy.findUsers();

			sendNotification(UserManagerProxy.LOAD_DATA_SUCCESS);
		}
	}
}