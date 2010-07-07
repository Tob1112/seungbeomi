package suite.icontact {
    import com.adobe.cairngorm.business.ServiceLocator;

    import mx.rpc.AsyncToken;
    import mx.rpc.IResponder;
    import mx.rpc.remoting.RemoteObject;

    import suite.Constants;


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
            // call server side method
            //trace("client : username - " + user.username + ", password - " + user.password);
            var token:AsyncToken = service.login(user);
            token.addResponder(responder);
        }
    }
}

