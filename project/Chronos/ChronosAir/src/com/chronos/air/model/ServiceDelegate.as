package com.chronos.air.model {
	import com.adobe.cairngorm.business.ServiceLocator;
	import com.chronos.Constants;

	import mx.rpc.IResponder;
	import mx.rpc.remoting.RemoteObject;


	public class ServiceDelegate {

		private var serviceLocator:ServiceLocator = ServiceLocator.getInstance();
		private var service:RemoteObject;
		private var responder:IResponder;

		public function ServiceDelegate(responder:IResponder) {
			if (serviceLocator == null) {
				serviceLocator = ServiceLocator.getInstance();
			}
			service = serviceLocator.getRemoteObject(Constants.SERVICE_REMOTE_OBJECT);
			this.responder = responder;
		}

		public function logout():void {
			service.logout();
		}

	}
}