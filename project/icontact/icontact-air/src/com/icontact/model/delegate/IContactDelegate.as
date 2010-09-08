package com.icontact.model.delegate {

    import com.adobe.cairngorm.business.ServiceLocator;
    import com.icontact.Constants;
    import com.icontact.model.domain.User;

    import mx.rpc.AsyncToken;
    import mx.rpc.IResponder;
    import mx.rpc.remoting.RemoteObject;

    public class IContactDelegate {
        private var locator:ServiceLocator = ServiceLocator.getInstance();
        private var service:RemoteObject;
        private var responder:IResponder;

        public function IContactDelegate(responder:IResponder) {
            if (locator == null) {
                locator = ServiceLocator.getInstance();
            }
            service = locator.getRemoteObject(Constants.ICONTACT_REMOTE_OBJECT);
            this.responder = responder;
        }

        public function login(user:User):void {
        	trace("login : " + user.account + ", " + user.password);
            // call server side method
            var token:AsyncToken = service.login(user);
            token.addResponder(responder);
        }
    }
}

