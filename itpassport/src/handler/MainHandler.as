package handler
{
	import flash.events.MouseEvent;

	import mx.controls.Alert;
	import mx.core.IMXMLObject;
	import mx.events.FlexEvent;

	public class MainHandler implements IMXMLObject
	{
		private var doc:main;
		private var isAppSettingMode:Boolean = false;

		public function initialized(document:Object, id:String):void {
           doc = document as main;
           doc.addEventListener(FlexEvent.CREATION_COMPLETE, creationCompleteHandler);
        }

        private function creationCompleteHandler(e:FlexEvent):void {
           	//終了 - メインに戻る
           	doc.btnReturnToMain.addEventListener(MouseEvent.CLICK, clickBtnReturnToMain);
           	//テストスタート
           	doc.btnTestStart.addEventListener(MouseEvent.CLICK,clickBtnTestStart);
           	//履歴
           	doc.btnHistory.addEventListener(MouseEvent.CLICK,clickBtnHistory);
           	//履歴を初期化
           	doc.btnInitHistory.addEventListener(MouseEvent.CLICK, clickBtnInitHistory);
			//履歴からメインに戻る
			doc.btnReturnToMainFromHistory.addEventListener(MouseEvent.CLICK, clickBtnReturnToMainFromHistory);
			//アプリケーション終了
			doc.btnClose.addEventListener(MouseEvent.CLICK, clickBtnClose);

		   	doc.viewStack.selectedChild = doc.mainView;
        }

		//終了 - メインに戻る
        private function clickBtnReturnToMain(e:MouseEvent):void {
			doc.currentState = "";
			doc.viewStack.selectedChild = doc.mainView;
        }

        //テストスタート
        private function clickBtnTestStart(e:MouseEvent):void {
        	doc.currentState = "testState";
        	doc.viewStack.selectedChild = doc.testView;
        }

        //履歴
        private function clickBtnHistory(e:MouseEvent):void {
			doc.currentState = "historyState";
			doc.viewStack.selectedChild = doc.historyView;
        }

		//履歴を初期化
        private function clickBtnInitHistory(e:MouseEvent):void {
			Alert.show("履歴を初期化");
        }

        //履歴からメインに戻る
		private function clickBtnReturnToMainFromHistory(e:MouseEvent):void {
			clickBtnReturnToMain(e);
		}

		//アプリケーション終了
		private function clickBtnClose(e:MouseEvent):void {
			Alert.show("アプリケーション終了");
		}

	}
}