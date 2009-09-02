package seungbeomi.model
{
	import mx.collections.ArrayCollection;
	import mx.managers.CursorManager;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;

	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;

	import seungbeomi.model.business.UserManagerDelegate;
	import seungbeomi.model.vo.UserVO;

	public class UserManagerProxy extends Proxy implements IProxy
	{
		public static const NAME:String = "userManagerProxy";
		
		//notification name constants
		public static const LOGOUT_FAILED:String = "logOutFailed";
 		public static const LOGOUT_SUCCESS:String = "logOutSuccess";
 		public static const LOAD_DATA_FAILED:String = "loadDataFailed";
 		public static const LOAD_DATA_SUCCESS:String = "loadDataSuccess";

		//error message
		public var faultMessage:String;

		/**
		 * constructor
		 *
		 * @param Proxy's data if necessary
		 * */
		public function UserManagerProxy(data:Object = null)
		{
			super(NAME, new ArrayCollection());
		}

		public function get users():ArrayCollection
		{
			return data as ArrayCollection;
		}

		 /**
		 * Calls the remoting service passing users data
		 *
		 * @param 	users data as UserVO
		 */

		/**
		 * find
		 * */
		public function findUsers():void
		{
			var delegate:UserManagerDelegate = new UserManagerDelegate(new Responder(findUsersResult, serviceFault))
			delegate.findUsers();
			CursorManager.setBusyCursor();
		}
		private function findUsersResult(event: ResultEvent):void
		{
			CursorManager.removeBusyCursor();

			users.source = event.result as Array;
		}

		/**
		 * create
		 * */
		public function createUser(userVO: UserVO):void
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

		/**
		 * updaate
		 * */
		public function updateUser(userVO: UserVO):void
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

		/**
		 * delete
		 * */
		public function deleteUser(userId:String):void
		{
			CursorManager.removeBusyCursor();

			var delegate:UserManagerDelegate = new UserManagerDelegate(new Responder(deleteUserResult, serviceFault))
			delegate.deleteUser(userId);
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