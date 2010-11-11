package com.chronos.air.view.controller {

	import com.chronos.air.model.Kinmuhyo;
	import com.chronos.air.model.KinmuhyoModel;
	import com.chronos.air.model.KinmuhyoShosai;
	import com.chronos.air.view.KinmuhyoShinkiSakuseiWindow;

	import flash.events.MouseEvent;

	import mx.collections.ArrayCollection;
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
			view.shigyoJikanComboBox.addEventListener(ListEvent.CHANGE, changeJikokuHandler);	// 始業時刻更新
			view.shuryouJikanComboBox.addEventListener(ListEvent.CHANGE, changeJikokuHandler);	// 終了時刻更新
			view.kyukeiJikanComboBox.addEventListener(ListEvent.CHANGE, changeJikokuHandler);	// 休憩時刻更新
		}

		/** 勤務表新規作成ウィンドウを閉じる */
		private function closeWindowHandler(e:*):void {
			PopUpManager.removePopUp(view);
		}

		/** 勤務表作成 */
		private function kinmuhyoSakuseiHandler(e:MouseEvent):void {
			// 勤務表に反映
			var kinmuhyo:Kinmuhyo = Kinmuhyo.createDefaultKinmuhyo();
			var kinmuhyoshosai:KinmuhyoShosai;
			var shinkiKinmuhyoShosaiAC:ArrayCollection = new ArrayCollection();

			var isDefaultHanei:Boolean = view.kinmuhyoHaneiCheckBox.selected;
			// 全反映
			if (isDefaultHanei) {

			// TODO 作業年月設定 REFACTORING
			} else {
				var year:int = view.shinkiKinmuhyoDateChooser.displayedYear;
				var month:int = view.shinkiKinmuhyoDateChooser.displayedMonth;
				var getsu:String = month.toString();

				// 月が１０以下の場合「０」を足す
				if (month < 10) {
					getsu = 0 + getsu;
				}

				// 勤務表年月設定
				kinmuhyo.nengetsu = year + "-" + getsu;
				model.kinmuhyo = kinmuhyo;

				// 勤務表詳細日付設定
				var date:Date = new Date();
				date.setFullYear(year, month, 1);

				var currentMonth:int = date.getMonth();
				for (var hizuke:int=1; hizuke < 32; hizuke++) {
					date.setFullYear(year, month, hizuke);
					if (date.getMonth() != currentMonth) {
						break;
					}
					kinmuhyoshosai = KinmuhyoShosai.createDefaultKinmuhyoShosai();
					kinmuhyoshosai.hizuke = new Date(year, month, hizuke);
					shinkiKinmuhyoShosaiAC.addItem(kinmuhyoshosai);
				}
				model.kinmuhyoShosaiAC = shinkiKinmuhyoShosaiAC;
			}
			// 親ウィンドウにイベントdispatch
			view.dispatchEvent(new PopupEvent(PopupEvent.SHINKI_KINMUHYO_HANEI));
			closeWindowHandler(e);	// ウィンドウを閉じる
		}

		/** 時刻更新 */
		private function changeJikokuHandler(e:ListEvent):void {
			var target:String = e.currentTarget.id;
			var jikoku:String = e.currentTarget.selectedItem.jikoku;
			var jikokuchi:Number = e.currentTarget.selectedItem.jikokuchi;
			switch (target) {
				case "shigyoJikanComboBox":
					model.shinkiKinmuhyo.shigyoJikan =  jikoku;
					model.shinkiKinmuhyo.shigyoJikanchi =  jikokuchi;
					break;
				case "shuryouJikanComboBox":
					model.shinkiKinmuhyo.syuryoJikan = jikoku;
					model.shinkiKinmuhyo.syuryoJikanchi = jikokuchi;
					break;
				case "kyukeiJikanComboBox":
					model.shinkiKinmuhyo.kyukeiJikan = jikokuchi;
					break;
			}

		}
		/** 時間ComboBox Label Function */
		public function kyukeiJikanComboBoxLabelFunction(item:Object):String {
			var kyukeiJikan:Number = item.jikokuchi as Number;
			return kyukeiJikan + " 時間";
		}
	}
}