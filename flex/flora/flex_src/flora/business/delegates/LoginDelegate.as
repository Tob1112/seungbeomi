package flora.business.delegates {

	import com.adobe.cairngorm.business.ServiceLocator;

	import flora.vo.User;

	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	import mx.rpc.remoting.RemoteObject;

    public class LoginDelegate {
    	private var _locator:ServiceLocator = ServiceLocator.getInstance();
    	private var _service:RemoteObject;
    	private var _responder:IResponder;

        public function LoginDelegate(responder:IResponder) {
        	trace("LoginDelegate");
        	_service = _locator.getRemoteObject("securityRO");
        	_responder = responder;
        }

        public function login(user:User):void {
        	trace("login - userId:" + user.userId + ", pw:" + user.password);
        	var token:AsyncToken = _service.authenticateUser(user.userId, user.password);
        	//var token:AsyncToken = _service.test();
        	token.addResponder(_responder);
        }

    }
}