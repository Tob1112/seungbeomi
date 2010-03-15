package org.chronos.authentication {

	import com.adobe.cairngorm.business.ServiceLocator;

	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	import mx.rpc.remoting.RemoteObject;

	import org.chronos.model.AuthorizationData;

    public class AuthenticationDelegate {

    	private var locator:ServiceLocator;
    	private var service:RemoteObject;
    	private var responder:IResponder;

        public function AuthenticationDelegate(responder:IResponder) {
        	if (locator == null) locator = ServiceLocator.getInstance();

        	service = locator.getRemoteObject("authenticationRO");
        	this.responder = responder;
        }

        /** login */
        public function authenticateUser(authorizationData:AuthorizationData):void {
            /*
            var httpService:HTTPService = new HTTPService();
        	httpService.url = "j_spring_security_check";
        	httpService.method = "POST";
        	var params:Object = new Object();
        	params.j_username = empName;
        	params.j_password = password;

			trace("authenticateUser : " + empName + " - " + password);

            var token:AsyncToken = httpService.send(params);
            token.addResponder(responder);
            */
            trace("authenticateUser : " + authorizationData.username + " - " + authorizationData.password);
            var token:AsyncToken = service.authenticateUser(authorizationData);
            token.addResponder(responder);
        }

    }
}