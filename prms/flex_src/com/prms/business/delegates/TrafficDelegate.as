package com.prms.business.delegates {
	import com.adobe.cairngorm.business.ServiceLocator;
	import com.prms.Constants;

	import mx.rpc.IResponder;
	import mx.rpc.remoting.mxml.RemoteObject;

	public class TrafficDelegate {
		private var locator:ServiceLocator = ServiceLocator.getInstance();
		private var service:RemoteObject;
		private var responder:IResponder;

		public function TrafficDelegate(responder:IResponder) {
			if( locator == null ){
				locator = ServiceLocator.getInstance();
			}

			service = locator.getRemoteObject(Constants.PRMS_REMOTE_OBJECT);
			responder = responder;
		}
	}
}