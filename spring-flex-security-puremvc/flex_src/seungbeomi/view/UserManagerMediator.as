package seungbeomi.view
{
	import flash.events.Event;

	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;

	import seungbeomi.ApplicationFacade;
	import seungbeomi.model.UserManagerProxy;
	import seungbeomi.view.components.UserManagerPanel;

	/**
	 * A Mediator for interacting with the UserManager component.
	 * */
	public class UserManagerMediator extends Mediator implements IMediator
	{
		private var _userManagerProxy:UserManagerProxy;

		public static const NAME:String = "UserManagerMediator";

		/**
		 * Constructor.
		 * @Param object the viewComponent.
		 * */
		 public function UserManagerMediator(viewComponent: UserManagerPanel)
		 {
		 	super(NAME, viewComponent);

		 	// local reference to the UserManagerProxy
		 	_userManagerProxy = facade.retrieveProxy( UserManagerProxy.NAME ) as UserManagerProxy;

		 	// listen to events dispatched by its view component.
		 	userManagerPanel.addEventListener(UserManagerPanel.LOGOUT, logout);
		 	userManagerPanel.addEventListener(UserManagerPanel.LOAD_DATA, loadData);
		 	//UserManagerPanel.addEventListener(UserManagerPanel.FIND_USER_BY_USERID, userManager);
		 }

		 private function logout (event: Event = null):void
		 {
		 	sendNotification( ApplicationFacade.USER_MANAGER);
		 }

		 private function loadData (event: Event = null):void
		 {
		 	sendNotification( ApplicationFacade.USER_MANAGER);
		 }




		/**
		 * List all notifications this Mediator is interested in.
		 *
		 * @return Array the list of Nofitication names
		 */
		 override public function listNotificationInterests():Array
		 {
		 	return [
		 		UserManagerProxy.LOGOUT_FAILED,
		 		UserManagerProxy.LOGOUT_SUCCESS,
		 		UserManagerProxy.LOAD_DATA_FAILED,
		 		UserManagerProxy.LOAD_DATA_SUCCESS
		 	];
		 }

		/**
		 * Handle all notifications this Mediator is interested in.
		 *
		 * @param INotification a notification
		 */
		 override public function handleNotification(notification:INotification):void
		 {
		 	switch ( notification.getName() )
		 	{
		 		case UserManagerProxy.LOGOUT_FAILED:

		 		break;
		 		case UserManagerProxy.LOGOUT_SUCCESS:

		 		break;
		 		default:
		 	}
		 }

		 /**
		 * Cast the viewComponent to its actual type.
		 * @return app the viewComponent cast to LoginPanel
		 */
		protected function get userManagerPanel(): UserManagerPanel
		{
			return viewComponent as UserManagerPanel;
		}
	}
}