package sample.flex
{
	import flash.events.MouseEvent;

	import mx.core.IMXMLObject;
	import mx.events.FlexEvent;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.RemoteObject;
	import mx.validators.Validator;

	import sample.flex.dto.User;

	public class LoginCanvasController implements IMXMLObject
	{
		public var document:LoginCanvas;
		public var userModel:UserModel;
		public var listCanvasController:ListCanvasController;

		//==================================
		//		initialization
		//==================================
		public function initialized(document:Object, id:String):void
		{
			this.document = document as LoginCanvas;
			this.document.addEventListener(FlexEvent.CREATION_COMPLETE, createHandler);
		}

		public function createHandler(event:FlexEvent):void
		{
			this.document.btnLogin.addEventListener(MouseEvent.CLICK, btnLoginEventHandler);
			this.document.txtUserId.addEventListener(FlexEvent.ENTER, btnLoginEventHandler);
			this.document.txtPassword.addEventListener(FlexEvent.ENTER, btnLoginEventHandler);
		}

		public function btnLoginEventHandler(event:*):void
		{
			document.validators.forEach(function(item:Object, index:int, array:Array):void {
				item.enabled = true;
			});

			loginHandler();

			var validatorResult:Array = Validator.validateAll(document.validators);
			if (validatorResult.length > 0) {
				return;
			}

		}

		//==================================
		//		login
		//==================================
		public function loginHandler():void
		{
			var userRO:RemoteObject = new RemoteObject();
			userRO.destination="userService";
			userRO.addEventListener('result', loginResultHandler);
			userRO.addEventListener('fault', serviceFaultHandler);
			userRO.authenticateUser(document.txtUserId.text, document.txtPassword.text);
		}

		private function loginResultHandler(event:ResultEvent):void {
			document.validators.forEach(function(item:Object, index:int, array:Array):void {
				item.enabled = false;
			});

			userModel = new UserModel();
			document.parentApplication.userModel.user = event.result as User;

			document.parentApplication.viewStack.selectedIndex = 1;
			document.parentApplication.loginCanvas.txtUserId.text = "";
			document.parentApplication.loginCanvas.txtPassword.text = "";
			document.errorMessage.visible = false;

		}

		//==================================
		//		session
		//==================================
		public function createSession(userId:String):void
		{
			var userRO:RemoteObject = new RemoteObject();
			userRO.destination="userService";
			userRO.addEventListener('result', serviceResultHandler);
			userRO.addEventListener('fault', serviceFaultHandler);
			userRO.createSession(userId);
		}

		//==================================
		//		common handler
		//==================================
		private function serviceResultHandler(event:ResultEvent):void {
			//Alert.show("success!!");
		}
		private function serviceFaultHandler(event:FaultEvent):void {
			document.errorMessage.visible = true;
			document.errorMessage.text = event.fault.faultString as String;

			document.parentDocument.faultEffect.end();
			document.parentDocument.faultEffect.play();
		}
	}
}