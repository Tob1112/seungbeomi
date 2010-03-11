package org.april27.home {

	import com.adobe.cairngorm.business.ServiceLocator;

	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	import mx.rpc.http.HTTPService;
	import mx.rpc.remoting.RemoteObject;

    public class HomeDelegate {

    	private var locator:ServiceLocator;
    	private var service:RemoteObject;
    	private var responder:IResponder;

        public function HomeDelegate(responder:IResponder) {
        	//if (locator == null) locator = ServiceLocator.getInstance();

        	//service = locator.getRemoteObject("homeRO");
        	this.responder = responder;
        }

        /** login */
        public function authenticateUser(empName:String, password:String):void {
            trace(empName + " : " + password);

            var httpService:HTTPService = new HTTPService();
        	httpService.url = "j_spring_security_check";
        	httpService.method = "POST";
        	var params:Object = new Object();
        	params.j_username = empName;
        	params.j_password = password;

			trace("authenticateUser : " + empName + " - " + password);

            var token:AsyncToken = httpService.send(params);
            token.addResponder(responder);
        }

    }
}