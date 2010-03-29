package seungbeomi.model
{
	import mx.collections.ArrayCollection;
	import mx.managers.CursorManager;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.mxml.RemoteObject;

	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;

//	import seungbeomi.model.business.UserManagerDelegate;
	import seungbeomi.model.vo.UserVO;
	import seungbeomi.view.UserManagerMediator;

	public class UserManagerProxy extends Proxy implements IProxy
	{
		public static const NAME:String = "userManagerProxy";

		//notification name constants
		public static const LOGOUT_FAILED:String = "logOutFailed";
 		public static const LOGOUT_SUCCESS:String = "logOutSuccess";
 		public static const LOAD_DATA_FAILED:String = "loadDataFailed";
 		public static const LOAD_DATA_SUCCESS:String = "loadDataSuccess";

		private var _service: RemoteObject;
		private var _userManagerMediator: UserManagerMediator;

		public var usersData:ArrayCollection;

		//error message
		public var faultMessage:String;

		/**
		 * constructor
		 *
		 * @param Proxy's data if necessary
		 * */
		public function UserManagerProxy(data:Object = null)
		{
			super(NAME, new UserVO());

			_service = new RemoteObject();
	    	_service.destination="userService";

			// Result Event Handler
	    	_service.findUsers.addEventListener(ResultEvent.RESULT, findUsersResult);


	    	// Fault Event Handler
	    	_service.addEventListener(FaultEvent.FAULT,serviceFault);

		}

		 /**
		 * Calls the remoting service passing users data
		 *
		 * @param 	users data as UserVO
		 */
		public function findUsers():void
		{
			//var delegate:UserManagerDelegate = new UserManagerDelegate(new Responder(findUsersResult, serviceFault))
			//delegate.findUsers();

			_service.findUsers();
			CursorManager.setBusyCursor();
		}
		private function findUsersResult(event: ResultEvent):void
		{
			CursorManager.removeBusyCursor();

			//users.source = event.result as Array;
			usersData = event.result as ArrayCollection;


			//setData(result);

			sendNotification( UserManagerProxy.LOAD_DATA_SUCCESS );
		}

		/**
		 * create
		 * */
/*		public function createUser(userVO: UserVO):void
		{
			CursorManager.removeBusyCursor();

			var delegate:UserManagerDelegate = new UserManagerDelegate(new Responder(createUserResult, serviceFault))
			delegate.createUser(userVO);
		}
		private function createUserResult(event: ResultEvent):void
		{
			var userVO: UserVO = event.result as UserVO;
			users.addItem(userVO);
		}
*/
		/**
		 * updaate
		 * */
/*		public function updateUser(userVO: UserVO):void
		{
			CursorManager.removeBusyCursor();

			var delegate:UserManagerDelegate = new UserManagerDelegate(new Responder(updateUserResult, serviceFault))
			delegate.updateUser(userVO);
		}
		private function updateUserResult(event: ResultEvent):void
		{
			var userVO: UserVO = event.result as UserVO;

			var userId:String = userVO.userId;
			for(var i:int = 0; i < users.length; i++)
			{
				var user:UserVO = users.getItemAt(i) as UserVO;
				if(user.userId == userId){
					users.setItemAt(userVO, i);
					return;
				}
			}
		}
*/
		/**
		 * delete
		 * */
		public function deleteUser(userId:String):void
		{
			CursorManager.removeBusyCursor();

			//var delegate:UserManagerDelegate = new UserManagerDelegate(new Responder(deleteUserResult, serviceFault))
			//delegate.deleteUser(userId);
		}
		private function deleteUserResult(event: ResultEvent):void
		{

		}




		private function serviceFault(event: FaultEvent):void
		{
			faultMessage = event.fault.faultString;
			CursorManager.removeBusyCursor();
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