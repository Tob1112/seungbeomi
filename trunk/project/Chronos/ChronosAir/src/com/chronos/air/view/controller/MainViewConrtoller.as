package com.chronos.air.view.controller {

	import com.chronos.Constants;
	import com.chronos.air.common.Messages;
	import com.chronos.air.event.ApplicationEvent;
	import com.chronos.air.event.ShinseiServiceEvent;
	import com.chronos.air.model.ApplicationModel;
	import com.chronos.air.view.MainView;

	import flash.events.MouseEvent;

	import mx.core.IMXMLObject;
	import mx.events.FlexEvent;
	import mx.managers.CursorManager;

	public class MainViewConrtoller implements IMXMLObject{

		private var view:MainView;
		public var model:ApplicationModel = ApplicationModel.getInstance();
		private var messages:Messages = Messages.getInstance();

		public function initialized(doc:Object, id:String):void {
			view = doc as MainView;
			// イベント登録
			view.addEventListener(FlexEvent.CREATION_COMPLETE, creationCompletHandler);
			view.addEventListener(FlexEvent.INITIALIZE, applicationInitializeHandler);
		}

		public function creationCompletHandler(e:FlexEvent):void {
			// イベントの登録
			view.logoutButton.addEventListener(MouseEvent.CLICK, logoutHandler);

			// ViewStackをロックし、HOME画面を表示する。
			initMainView();
		}

		//----------------------------------------------------------------------------------------------

		/** アプリケーション初期化処理を行う */
		public function applicationInitializeHandler(e:FlexEvent):void {
			// アプリケーション初期化
			var event:ApplicationEvent = new ApplicationEvent(ApplicationEvent.INITIALIZE_APPLICATION);
			event.dispatch();
		}

		/** ViewStackをロックし、HOME画面を表示する。 */
		private function initMainView():void {
			view.mainViewStack.selectedIndex = Constants.HOME_VIEWSTACK_INDEX;
			view.shainMeiLabel.text = "";
			//view.shainMeiLabel.visible = false;
			view.logoutButton.visible = false;
			view.buttonBar.enabled = false;
		}

		/** ログアウト */
		private function logoutHandler(e:MouseEvent):void {
			var event:ShinseiServiceEvent = new ShinseiServiceEvent(ShinseiServiceEvent.LOGOUT, view);
			event.dispatch();
		}

	}
}