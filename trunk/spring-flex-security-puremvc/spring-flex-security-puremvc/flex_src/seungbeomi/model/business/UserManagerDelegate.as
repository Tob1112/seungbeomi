package seungbeomi.model.business
{
	import mx.managers.CursorManager;
	import mx.rpc.IResponder;
	import mx.rpc.remoting.mxml.RemoteObject;

	import seungbeomi.model.vo.UserVO;

	public class UserManagerDelegate
	{
		private var _service :RemoteObject;
		private var _responder:IResponder;

		public function UserManagerDelegate(pResponder:IResponder)
		{

			_service = new RemoteObject();
	    	_service.destination="userService";

	    	CursorManager.setBusyCursor();

			_responder = pResponder;
		}

		public function findUsers():void
		{
			var call:Object = _service.findUsers();
			call.addResponder(_responder);
		}

		public function findUserByUserId(userId:String):void
		{
			var call:Object = _service.findUserByUserId(userId);
			call.addResponder(_responder);
		}

		public function createUser(userVO: UserVO):void
		{
			var call:Object = _service.createUser(userVO);
			call.addResponder(_responder);
		}

		public function updateUser(userVO: UserVO):void
		{
			var call:Object = _service.updateUser(userVO);
			call.addResponder(_responder);
		}

		public function deleteUser(userId: String):void
		{
			var call:Object = _service.deleteUser(userId);
			call.addResponder(_responder);
		}
	}
}