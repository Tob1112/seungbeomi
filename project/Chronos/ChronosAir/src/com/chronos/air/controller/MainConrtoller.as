package com.chronos.air.controller {

	import com.chronos.Constants;
	import com.chronos.air.common.Messages;
	import com.chronos.air.model.MainEvent;
	import com.chronos.air.model.MainModel;
	import com.chronos.air.model.ServiceEvent;
	import com.chronos.air.view.MainView;

	import flash.events.MouseEvent;
	import flash.filesystem.File;

	import mx.core.IMXMLObject;
	import mx.events.FlexEvent;

	public class MainConrtoller implements IMXMLObject{

		private var view:MainView;
		public var model:MainModel = MainModel.getInstance();
		private var messages:Messages = Messages.getInstance();

		public function initialized(doc:Object, id:String):void {
			view = doc as MainView;
			// イベント登録
			view.addEventListener(FlexEvent.INITIALIZE, applicationInitializeHandler);
			view.addEventListener(FlexEvent.CREATION_COMPLETE, creationCompletHandler);
		}

		/** アプリケーション初期化処理を行う */
		public function applicationInitializeHandler(e:FlexEvent):void {
			//new MessageId();
			openDatabase();
		}

		public function creationCompletHandler(e:FlexEvent):void {
			// イベントの登録
			view.logoutButton.addEventListener(MouseEvent.CLICK, logoutHandler);

			// ViewStackをロックし、HOME画面を表示する。
			initMainView();
		}

		/** ViewStackをロックし、HOME画面を表示する。 */
		private function initMainView():void {
			view.mainViewStack.selectedIndex = Constants.HOME_VIEWSTACK_INDEX;
			view.nameLabel.text = "";
			view.nameLabel.visible = false;
			view.logoutButton.visible = false;
			view.buttonBar.enabled = false;
		}

		private function openDatabase():void {
			// システムディレクトリ生成
			var systemDir:File = File.userDirectory.resolvePath(Constants.SYSTEM_DIRECTORY_PATH);
			// システムディレクトリが存在しない場合
			if (!systemDir.exists) {
				systemDir.createDirectory();
			}
			var event:MainEvent = new MainEvent(MainEvent.OPEN_DATABASE);
			event.dispatch();
		}

		private function logoutHandler():void {
			var event:ServiceEvent = new ServiceEvent(ServiceEvent.LOGOUT, view);
			event.dispatch();
		}

	}
}