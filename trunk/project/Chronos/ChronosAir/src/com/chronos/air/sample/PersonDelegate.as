package com.chronos.air.sample
{
	import com.adobe.cairngorm.business.ServiceLocator;

	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	import mx.rpc.remoting.RemoteObject;

	public class PersonDelegate
	{
		private var serviceLocator:ServiceLocator = ServiceLocator.getInstance();
		private var service:RemoteObject;
		private var responder:IResponder;

		public function PersonDelegate(responder:IResponder)
		{
			if (serviceLocator == null) {
				serviceLocator = ServiceLocator.getInstance();
			}
			service = serviceLocator.getRemoteObject(Constants.PERSON_REMOTE_OBJECT);
			this.responder = responder;
		}

		public function sayHello(person:Person):void {
			var token:AsyncToken = service.sayHello(person);
			token.addResponder(responder);
		}

		/** File Upload */
		public function fileUpload(file:FileUpDownLoad):void {
			var token:AsyncToken = service.fileUpload(file);
			token.addResponder(responder);
		}
	}
}