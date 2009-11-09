package flora.business.commands {

	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;

	import flora.business.delegates.LoginDelegate;
	import flora.events.LoginEvent;
	import flora.model.ModelLocator;
	import flora.views.LoginWindow;
	import flora.vo.User;

	import mx.controls.Alert;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;


    public class LoginCommand implements ICommand {

    	private var _model:ModelLocator = ModelLocator.getInstance();
		private var _doc:LoginWindow;

    	public function execute(event:CairngormEvent):void {
			trace("execute");
			_doc = (event as LoginEvent).doc;
			var responder:Responder = new Responder(onResult_login, onFault_handler);
			var delegate:LoginDelegate = new LoginDelegate(responder);
    		delegate.login((event as LoginEvent).user);
    	}

		private function onResult_login(event:ResultEvent):void {
			trace("onResult_login");
			// Why isn't [_model.user] input? Why??
			_model.user = new User();
			_model.user.userId = event.result.userId;
			_model.user.roles = event.result.roles;

			Alert.show("userId:" + _model.user.userId);

			if (_model.user.isAdmin()) {
				_doc.txtMessage.text = "Admin";
			} else if (_model.user.isUser()) {
				_doc.txtMessage.text = "User";
			} else {
				Alert.show("You are not Role!!");
			}
		}

		private function onFault_handler(event:FaultEvent):void {
			_doc.txtMessage.text = event.fault.faultString;
			_doc.loginFaultEffect.end();
			_doc.loginFaultEffect.play();
		}
    }
}