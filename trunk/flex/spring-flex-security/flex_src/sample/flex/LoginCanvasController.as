package sample.flex
{
	import flash.events.MouseEvent;

	import mx.controls.Alert;
	import mx.core.IMXMLObject;
	import mx.events.FlexEvent;
	import mx.modules.ModuleLoader;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.RemoteObject;

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
			this.document.addEventListener(FlexEvent.CREATION_COMPLETE , createHandler);
		}

		public function createHandler(event:FlexEvent):void
		{
			this.document.btnLogin.addEventListener(MouseEvent.CLICK, btnLoginEventHandler);
		}

		public function btnLoginEventHandler(event:MouseEvent):void
		{
			loginHandler();
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

			userModel = new UserModel();
			document.parentApplication.userModel.user = event.result as User;

//			var mLoader:ModuleLoader = new ModuleLoader();
//			if (document.parentApplication.userModel.isAdmin() == true) {
//				trace("admin");
//				mLoader.url = "./sample/flex/module/AdminModule.swf";
//			} else {
//				trace("user");
//				mLoader.url = "./sample/flex/module/UserModule.swf";
//			}

			//create session
			//createSession(document.parentApplication.userModel.user.userId);

			//viewstack
//			document.parentApplication.moduleUrl = mLoader.url;
//			mLoader.loadModule();
			document.parentApplication.viewStack.selectedIndex = 1;
			document.parentApplication.loginCanvas.txtUserId.text = "";
			document.parentApplication.loginCanvas.txtPassword.text = "";
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
			Alert.show(event.fault.toString());
		}
	}
}