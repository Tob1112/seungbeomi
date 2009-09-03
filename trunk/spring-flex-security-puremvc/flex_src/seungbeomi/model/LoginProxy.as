package seungbeomi.model
{
	import mx.managers.CursorManager;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.mxml.RemoteObject;

	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;

	import seungbeomi.model.vo.UserVO;

	public class LoginProxy extends Proxy implements IProxy
	{
		public static const NAME:String = "loginProxy";

		//notification name constants
		public static const LOGIN_SUCCESS:String = "loginSuccess";
		public static const LOGIN_FAILED:String = "loginFailed";

		//login sevice
		private var _service:RemoteObject;

		//error message
		public var faultMessage:String;

		//other part of the model
		private var _appProxy:ApplicationProxy;

		/**
		 * constructor
		 *
		 * @param Proxy's data if necessary
		 * */
		 public function LoginProxy(data:Object = null)
		 {
		 	super(NAME, new UserVO());

		 	// A local reference to another part of the model
			// Note: Be carefull that the ApplicationProxy has already registered within
			// the ModelPrepCommand before
			_appProxy = facade.retrieveProxy( ApplicationProxy.NAME ) as ApplicationProxy;

			// login service
			_service = new RemoteObject();
			_service.destination = "userService";
			//_service.source = "seungbemomi.LoginFacade";

			_service.authenticateUser.addEventListener(ResultEvent.RESULT, loginResult);
			_service.addEventListener(FaultEvent.FAULT, loginFailed);
		 }

		 /**
		 * Calls the remoting service passing users data
		 *
		 * @param 	users data as UserVO
		 */
		public function login( vo: UserVO ):void
		{
			// authentication
			_service.authenticateUser( vo.userId, vo.password );

			// get User info
			//_service.findUserByUserId( vo.userId );

			CursorManager.setBusyCursor();
		}

		/**
		 * Receives the remoting service result users data
		 *
		 * @param 	result event object
		 */
		private function loginResult(event: ResultEvent):void
		{
			CursorManager.removeBusyCursor();

			// populate its data object using the result
			var userVO: UserVO = event.result as UserVO

			setData( userVO );

			// change the view state
			//_appProxy.viewState = ApplicationProxy.LOGGED_IN_STATE;
			_appProxy.viewState = ApplicationProxy.USER_MANAGER_STATE;

			// notify all interested members
			sendNotification( LoginProxy.LOGIN_SUCCESS );
		}

		/**
		 * Receives the remoting service fault event
		 *
		 * @param 	fault event object
		 */
		private function loginFailed(event: FaultEvent): void
		{
			faultMessage = event.fault.faultString;
			CursorManager.removeBusyCursor();

			// change the view state
			_appProxy.viewState = ApplicationProxy.LOGIN_ERROR_STATE;

			// notify all interested members
			sendNotification( LoginProxy.LOGIN_FAILED );
		}

		/**
		 * Getter for its data object casted as UserVO
		 *
		 * @return 	UserVO
		 */
		public function get userVO(): UserVO
		{
			return data as UserVO;
		}
	}
}