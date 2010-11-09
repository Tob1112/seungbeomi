package com.chronos.air.view.controller {

	import com.chronos.air.model.KinmuhyoModel;
	import com.chronos.air.util.Logger;
	import com.chronos.air.view.KinmuhyoShinkiSakuseiWindow;

	import flash.events.MouseEvent;

	import mx.core.IMXMLObject;
	import mx.events.CloseEvent;
	import mx.events.FlexEvent;
	import mx.events.ListEvent;
	import mx.managers.PopUpManager;

	public class KinmuhyoShinkiSakuseiWindowController implements IMXMLObject{

		private var view:KinmuhyoShinkiSakuseiWindow;
		[Bindable]
		public var model:KinmuhyoModel = KinmuhyoModel.getInstance();

		public function initialized(doc:Object, id:String):void {
			view = doc as KinmuhyoShinkiSakuseiWindow;
			view.addEventListener(FlexEvent.CREATION_COMPLETE, creationComplementHandler);
		}

		public function creationComplementHandler(e:FlexEvent):void {
			view.kinmuhyoSakuseiButton.addEventListener(MouseEvent.CLICK, kinmuhyoSakuseiHandler);	// 新規勤務表作成
			view.cancelButton.addEventListener(MouseEvent.CLICK, closeWindowHandler);	// ウィンドウを閉じる
			view.addEventListener(CloseEvent.CLOSE, closeWindowHandler);	// ウィンドウを閉じる
			view.shigyoJikanComboBox.addEventListener(ListEvent.CHANGE, changeJikokuHandler);	// 時刻更新
			view.shuryouJikanComboBox.addEventListener(ListEvent.CHANGE, changeJikokuHandler);	// 時刻更新
			view.kyukeiJikanComboBox.addEventListener(ListEvent.CHANGE, changeJikokuHandler);	// 時刻更新
		}

		/** 勤務表新規作成ウィンドウを閉じる */
		private function closeWindowHandler(e:*):void {
			PopUpManager.removePopUp(view);
		}

		/** 勤務表作成 */
		private function kinmuhyoSakuseiHandler(e:MouseEvent):void {
			// TODO 勤務表に反映

		}
		/** 時刻更新 */
		private function changeJikokuHandler(e:ListEvent):void {
			Logger.log(e.currentTarget.selectedItem.jikoku + " - " + e.currentTarget.selectedItem.jikokuchi);

		}
		/** 時間ComboBox Label Function */
		public function kyukeiJikanComboBoxLabelFunction(item:Object):String {
			var kyukeiJikan:Number = item.jikokuchi as Number;
			return kyukeiJikan + " 時間";
		}


	}
}