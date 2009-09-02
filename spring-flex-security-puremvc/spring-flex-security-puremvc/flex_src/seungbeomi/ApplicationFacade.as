package seungbeomi
{
	import org.puremvc.as3.patterns.facade.Facade;

	import seungbeomi.controller.ApplicationStartupCommand;
	import seungbeomi.controller.LoginCommand;
	import seungbeomi.controller.UserManagerCommand;

	public class ApplicationFacade extends Facade
	{
		/**
		 * Notification name constants
		 * */
		public static const APP_STARTUP:String = "appStartup";
		public static const LOGIN:String = "login";
		public static const USER_MANAGER:String = "userManager";

		/**
		 * Singleton ApplicationFacade Factory Method
		 * */
		 public static function getInstance():ApplicationFacade
		 {
		 	if (instance == null) instance = new ApplicationFacade();
		 	return instance as ApplicationFacade;
		 }

		 /**
		 * Register Commands with the Controller
		 * */
		 override protected function initializeController():void
		 {
		 	super.initializeController();

		 	//register commands
		 	registerCommand(APP_STARTUP, ApplicationStartupCommand);	// MacroCommand
		 	registerCommand(LOGIN, LoginCommand);
		 	registerCommand(USER_MANAGER, UserManagerCommand);
		 }

		 public function startup(app:Main4PureMVC):void
		 {
		 	this.sendNotification(ApplicationFacade.APP_STARTUP, app);
		 }

	}
}