package business.delegates
{
	import com.adobe.cairngorm.business.ServiceLocator;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	import mx.rpc.http.HTTPService;
	public class PhotoDelegate
	{
		private var __locator:ServiceLocator=ServiceLocator.getInstance(); 
		private var __service:HTTPService;
		private var __responder:IResponder;
		public function PhotoDelegate(responder:IResponder)
		{
			__service = __locator.getHTTPService("photosIn");
			__responder = responder;
		}
		public function loadPhotos():void
		{
			var token:AsyncToken = __service.send();
			token.addResponder(__responder);
		}
	}
}