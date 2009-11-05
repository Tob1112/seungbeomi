package sample.flex
{
	import flash.events.MouseEvent;

	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.core.IMXMLObject;
	import mx.events.FlexEvent;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.RemoteObject;

	public class ListCanvasController implements IMXMLObject {

		public var document:ListCanvas;
		public var userModel:UserModel;

		//==================================
		//		initialization
		//==================================
		public function initialized(document:Object, id:String):void {
			this.document = document as ListCanvas;
			this.document.addEventListener(FlexEvent.CREATION_COMPLETE , createHandler);
		}

		public function createHandler(event:FlexEvent):void {
			this.document.btnLogout.addEventListener(MouseEvent.CLICK, btnLogoutEventHandler);
			this.document.btnLoadData.addEventListener(MouseEvent.CLICK, btnLoadDataEventHandler);
		}


		public function btnLogoutEventHandler(event:MouseEvent):void {
			logoutHandler();
		}

		public function btnLoadDataEventHandler(event:MouseEvent):void {
			loadDataHandler();
		}

		//==================================
		//		load data
		//==================================
		public function loadDataHandler():void {
			var groups:Array = document.parentApplication.userModel.user.groups;
			var userId:String = document.parentApplication.userModel.user.userId;

			var userRO:RemoteObject = new RemoteObject();
			userRO.destination="userService";
			userRO.addEventListener("result", loadUserListResultHandler);
			userRO.addEventListener("fault", serviceFaultHandler);

			if (document.parentApplication.userModel.isAdmin()) {
				userRO.findUsers();
			} else if (document.parentApplication.userModel.isUser()) {
				userRO.findUserByUserId(userId);
			} else {
				Alert.show("not role !!");
			}
		}

		public function loadUserListResultHandler(event:ResultEvent):void {
			document.dg.dataProvider = event.result;
		}

		//==================================
		//		logout
		//==================================
		public function logoutHandler():void {

			var userRO:RemoteObject = new RemoteObject();
			userRO.destination = "userService";
			userRO.addEventListener('result', serviceResultHandler);
			userRO.addEventListener('fault', serviceFaultHandler);
			userRO.removeSession();

			document.dg.dataProvider = null;
			document.parentApplication.viewStack.selectedIndex = 0;

		}

		//==================================
		//		common handler
		//==================================
		private function serviceResultHandler(event:ResultEvent):void {
			//Alert.show("success");
		}
		private function serviceFaultHandler(event:FaultEvent):void {
			Alert.show(event.fault.toString());
		}
	}
}
