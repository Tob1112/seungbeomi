package org.chronos.air.model {
	import com.adobe.cairngorm.business.ServiceLocator;
	import org.chronos.Constants;

	import mx.managers.CursorManager;
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

		//---------------------------------------------------------------------------

		/** ログイン */
		public function login(shain:Shain):void {
			var token:AsyncToken = service.login(shain);
			token.addResponder(responder);
		}

		/** ログアウト */
		public function logout():void {
			service.logout();
		}

		/** 勤務表送信 */
		public function sendKinmuhyo(shinsei:Shinsei):void {
			CursorManager.removeBusyCursor();	// TODO delete
			var token:AsyncToken = service.sendKinmuhyo(shinsei);
			token.addResponder(responder);
		}
	}
}