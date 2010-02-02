package handler
{
	import flash.events.MouseEvent;

	import mx.core.IMXMLObject;
	import mx.events.FlexEvent;

	public class MainHandler implements IMXMLObject
	{
		private var doc:main;
		private var isAppSettingMode:Boolean = false;

		public function initialized(document:Object, id:String):void {
           doc = document as main;
           doc.addEventListener(FlexEvent.CREATION_COMPLETE, creationCompleteHandler);

           //終了 - メインに戻る
           doc.btnReturnToMain.addEventListener(MouseEvent.CLICK, clickBtnReturnToMain);
           //テストスタート
           doc.btnTestStart.addEventListener(MouseEvent.CLICK,clickBtnTestStart);
           //履歴
           doc.btnHistory.addEventListener(MouseEvent.CLICK,clickBtnHistory);
        }

        private function creationCompleteHandler(e:FlexEvent):void {

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
			doc.currentState = "";
			doc.viewStack.selectedChild = doc.historyView;
        }


	}
}