package com.chronos.air.view.controller {

	import com.chronos.air.model.KinmuhyoModel;
	import com.chronos.air.view.KinmuhyoShinkiSakuseiWindow;

	import flash.events.MouseEvent;

	import mx.core.IMXMLObject;
	import mx.events.CloseEvent;
	import mx.events.FlexEvent;
	import mx.managers.PopUpManager;

	public class KinmuhyoShinkiSakuseiWindowController implements IMXMLObject{

		private var view:KinmuhyoShinkiSakuseiWindow;
		public var model:KinmuhyoModel = KinmuhyoModel.getInstance();

		public function initialized(doc:Object, id:String):void {
			view = doc as KinmuhyoShinkiSakuseiWindow;
			view.addEventListener(FlexEvent.CREATION_COMPLETE, creationComplementHandler);
		}

		public function creationComplementHandler(e:FlexEvent):void {
			view.kinmuhyoSakuseiButton.addEventListener(MouseEvent.CLICK, kinmuhyoSakuseiHandler);	// 新規勤務表作成
			view.cancelButton.addEventListener(MouseEvent.CLICK, closeWindowHandler);	// ウィンドウを閉じる
			view.addEventListener(CloseEvent.CLOSE, closeWindowHandler);	// ウィンドウを閉じる
		}

		/** 勤務表新規作成ウィンドウを閉じる */
		private function closeWindowHandler(e:*):void {
			PopUpManager.removePopUp(view);
		}

		/** 勤務表作成 */
		private function kinmuhyoSakuseiHandler(e:MouseEvent):void {

		}

	}
}