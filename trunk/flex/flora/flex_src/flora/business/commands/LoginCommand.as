package flora.business.commands {

	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;

	import flora.business.delegates.LoginDelegate;
	import flora.events.LoginEvent;
	import flora.model.ModelLocator;
	import flora.vo.User;

	import mx.controls.Alert;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;


    public class LoginCommand implements ICommand {

    	private var _model:ModelLocator = ModelLocator.getInstance();
		private var loginEvent:LoginEvent;
		private var delegate:LoginDelegate;

    	public function execute(event:CairngormEvent):void {
			trace("execute");
    		switch (event.type) {
    			case LoginEvent.EVENT_LOGIN:
    				login((event as LoginEvent).user);
    				break;
    		}
    	}

		private function login(user:User):void {
			trace("LoginCommand login - userId:" + user.userId + ", pw:" + user.password);
			var responder:Responder = new Responder(onResult_login, onFault_handler);
			var delegate:LoginDelegate = new LoginDelegate(responder);
    		delegate.login(user);
		}

		private function onResult_login(e:ResultEvent):void {
			trace("onResult_login");
			// Why isn't [_model.user] input? Why??
			_model.user = e.result as User;

			//Alert.show("userId:" + user.userId);

			if (_model.user.isAdmin()) {
				Alert.show("Admin");
			} else if (_model.user.isUser()) {
				Alert.show("User");
			} else {
				Alert.show("You are not Role!!");
			}
		}

		private function onFault_handler(e:FaultEvent):void {
			Alert.show(e.fault.toString());

		}
    }
}