package com.chronos.air.model {
	import com.adobe.cairngorm.business.ServiceLocator;
	import com.chronos.Constants;

	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	import mx.rpc.remoting.RemoteObject;


	public class ShinseiServiceDelegate {

		private var serviceLocator:ServiceLocator = ServiceLocator.getInstance();
		private var service:RemoteObject;
		private var responder:IResponder;

		public function ShinseiServiceDelegate(responder:IResponder) {
			if (serviceLocator == null) {
				serviceLocator = ServiceLocator.getInstance();
			}
			service = serviceLocator.getRemoteObject(Constants.SERVICE_REMOTE_OBJECT);
			this.responder = responder;
		}

		// ログイン
		public function login(user:User):void {
			var token:AsyncToken = service.login(user);
			token.addResponder(responder);
		}

		// ログアウト
		public function logout():void {
			service.logout();
		}

	}
}