package seungbeomi.model
{
	import mx.managers.CursorManager;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.mxml.RemoteObject;

	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;

	import seungbeomi.model.vo.UserVO;

	public class testUserManagerProxy extends Proxy implements IProxy
	{
		public static const NAME:String = "userManagerProxy";

		//notification name constants
		public static const FIND_USERS_SUCCESS:String = "findUsersSuccess";
		public static const FIND_USERS_FAILED:String = "findUsersFailed";

		public static const FIND_USER_BY_USERID_AND_PASSWORD_SUCCESS:String = "findUserByUserIdAndPasswordSuccess";
		public static const FIND_USER_BY_USERID_AND_PASSWORD_FAILED:String = "findUserByUserIdAndPasswordFailed";

		public static const FIND_USER_BY_USERID_SUCCESS:String = "findUserByUserIdSuccess";
		public static const FIND_USER_BY_USERID_FAILED:String = "findUserByUserIdFailed";

		public static const CREATE_USER_SUCCESS:String = "createUserSuccess";
		public static const CREATE_USER_FAILED:String = "createUserFailed";

		public static const UPDATE_USER_SUCCESS:String = "updateUserSuccess";
		public static const UPDATE_USER_FAILED:String = "updateUserFailed";

		public static const DELETE_USER_SUCCESS:String = "deleteUserSuccess";
		public static const DELETE_USER_FAILED:String = "deleteUserFailed";


		//login sevice
		private var _userService:RemoteObject;

		//error message
		public var faultMessage:String;

		//other part of the model
		private var _appProxy:ApplicationProxy;

		/**
		 * constructor
		 *
		 * @param Proxy's data if necessary
		 * */
		 public function UserManagerProxy(data:Object = null)
		 {
		 	super(NAME, new UserVO());

		 	// A local reference to another part of the model
			// Note: Be carefull that the ApplicationProxy has already registered within
			// the ModelPrepCommand before
			_appProxy = facade.retrieveProxy( ApplicationProxy.NAME ) as ApplicationProxy;

			// login service
			_userService = new RemoteObject();
			_userService.destination = "userService";
			//_loginService.source = "org.puremvc.as3.demos.flex.weborb.login.LoginFacade";

			_userService.getUser.addEventListener(ResultEvent.RESULT, getUserResult);
			_userService.addEventListener(FaultEvent.FAULT, getUserFailed);
		 }

		 /**
		 * Calls the remoting service passing users data
		 *
		 * @param 	users data as UserVO
		 */
		public function getUser( vo: UserVO ):void
		{
			_userService.getUser( vo );
			CursorManager.setBusyCursor();
		}

		/**
		 * Receives the remoting service result users data
		 *
		 * @param 	result event object
		 */
		private function getUserResult(event: ResultEvent):void
		{
			CursorManager.removeBusyCursor();

			// populate its data object using the result
			var userVO: UserVO = event.result as UserVO
			//userVO.loginDate = new Date();
			setData( userVO );

			// change the view state
			_appProxy.viewState = ApplicationProxy.LOGGED_IN_STATE;

			// notify all interested members
			//sendNotification( loginProxy.LOGIN_SUCCESS );
		}

		/**
		 * Receives the remoting service fault event
		 *
		 * @param 	fault event object
		 */
		private function getUserFailed(event: FaultEvent): void
		{
			faultMessage = event.fault.faultString;
			CursorManager.removeBusyCursor();

			// change the view state
			_appProxy.viewState = ApplicationProxy.LOGIN_ERROR_STATE;

			// notify all interested members
			//sendNotification( loginProxy.LOGIN_FAILED );
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