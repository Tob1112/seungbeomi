package seungbeomi.model
{
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;

	public class ApplicationProxy extends Proxy implements IProxy
	{
		public static const NAME:String = "ApplicationProxy";

		//notification name constant
		public static const VIEW_STATE_CHANGED:String = "viewStateChanged";

		private var _viewState:uint;

		public static const LOGIN_STATE:uint = 1;
		public static const LOGGED_IN_STATE:uint = 2;
		public static const LOGIN_ERROR_STATE:uint = 3;
		public static const USER_MANAGER_STATE:uint = 4;
		public static const TEST_STATE:uint = 5;

		/**
		 * constructor
		 * */
		 public function ApplicationProxy(data:Object = null)
		 {
		 	super(NAME, data);
		 }

		 /**
		 * Sets the state of the application "workflow"
		 * @param integer wich based on constants defined by ApplicationProxy
		 * */
		 public function set viewState(value:uint):void
		 {
		 	_viewState = value;
		 	sendNotification(ApplicationProxy.VIEW_STATE_CHANGED);
		 }

		 /**
		 * Gets the state of the login application
		 * @param uint The state id of the app
		 * */
		 public function get viewState():uint
		 {
		 	return _viewState;
		 }
	}
}