package seungbeomi.controller
{
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;

	import seungbeomi.model.ApplicationProxy;
	import seungbeomi.model.LoginProxy;
	import seungbeomi.model.UserManagerProxy;

	public class ModelPrepCommand extends SimpleCommand
	{
		/**
		 * Register the Proxies.
		 * */
		 override public function execute(notification:INotification):void
		 {
		 	facade.registerProxy(new ApplicationProxy());
		 	facade.registerProxy(new LoginProxy());
		 	facade.registerProxy(new UserManagerProxy());
		 }
	}
}