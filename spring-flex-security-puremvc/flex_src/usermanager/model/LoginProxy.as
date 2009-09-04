package usermanager.model
{
	import mx.managers.CursorManager;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.mxml.RemoteObject;

	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;

	import usermanager.model.vo.UserVO;
	import usermanager.view.ApplicationMediator;

	public class LoginProxy extends Proxy implements IProxy
	{
		public static const NAME: String = "LoginProxy";

		// remote service
		private var _service:RemoteObject;

		// error message
		public var faultMessage:String;

		// other part of the model
		private var _appMediator:ApplicationMediator;

		public function LoginProxy(data:Object = null)
		{
			super (NAME, data);

			_appMediator = facade.retrieveMediator(ApplicationMediator.NAME) as ApplicationMediator;

			_service = new RemoteObject();
			_service.destination = "userService";

			_service.login.addEventListener(ResultEvent.RESULT, loginResult);
			_service.addEventListener(FaultEvent.FAULT, serviceFault);
		}

		public function login(userId:String, password:String):void
		{
			_service.login(userId, password) as UserVO;

			CursorManager.setBusyCursor();
		}

		private function loginResult(event:ResultEvent):void
		{
			CursorManager.removeBusyCursor();

			data = event.result as UserVO;
		}


		private function serviceFault(event:FaultEvent):void
		{
			faultMessage = event.fault.faultString;
			CursorManager.removeBusyCursor();

			//sendNotification(
		}


		//-------------------------------------------------------------
		public function get userVO():UserVO
		{
			return data as UserVO;
		}
	}
}