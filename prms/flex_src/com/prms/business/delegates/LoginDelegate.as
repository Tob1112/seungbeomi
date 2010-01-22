package com.prms.business.delegates
{
    import com.adobe.cairngorm.business.ServiceLocator;
    import com.prms.Constants;
    import com.prms.vo.Account;

    import mx.rpc.AsyncToken;
    import mx.rpc.IResponder;
    import mx.rpc.remoting.RemoteObject;

    public class LoginDelegate {

        private var _locator:ServiceLocator;
        private var _service:RemoteObject;
        private var _responder:IResponder;

        public function LoginDelegate(responder:IResponder) {
            if (_locator == null) {
                _locator = ServiceLocator.getInstance();
            }
            //_service = _locator.getRemoteObject("securityRO");
            _service = _locator.getRemoteObject(Constants.PRMS_REMOTE_OBJECT);
            _responder = responder;
        }

        public function login(account:Account):void {
            trace("login - account email:" + account.email + ", passwd:" + account.passwd);
            var token:AsyncToken = _service.authenticateUser(account);
            token.addResponder(_responder);
        }
    }
}

