package com.chronos.air.view.controller {

	import com.chronos.air.event.KinmuhyoEvent;
	import com.chronos.air.model.Kinmuhyo;
	import com.chronos.air.model.KinmuhyoModel;
	import com.chronos.air.model.KinmuhyoShosai;
	import com.chronos.air.model.ShinkiKinmuhyo;
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
		private var isUpdatedShigyoJikan:Boolean = false;
		private var isUpdatedSyuryoJikan:Boolean = false;
		private var isUpdatedKyukeiJikan:Boolean = false;

		public function initialized(doc:Object, id:String):void {
			view = doc as KinmuhyoShinkiSakuseiWindow;
			view.addEventListener(FlexEvent.CREATION_COMPLETE, creationComplementHandler);
		}

		public function creationComplementHandler(e:FlexEvent):void {
			view.kinmuhyoSakuseiButton.addEventListener(MouseEvent.CLICK, kinmuhyoSakuseiHandler);	// 新規勤務表作成
			view.cancelButton.addEventListener(MouseEvent.CLICK, closeWindowHandler);	// ウィンドウを閉じる
			view.addEventListener(CloseEvent.CLOSE, closeWindowHandler);	// ウィンドウを閉じる
			view.shigyoJikanComboBox.addEventListener(ListEvent.CHANGE, changeJikokuHandler);	// 始業時刻更新
			view.shuryoJikanComboBox.addEventListener(ListEvent.CHANGE, changeJikokuHandler);	// 終了時刻更新
			view.kyukeiJikanComboBox.addEventListener(ListEvent.CHANGE, changeJikokuHandler);	// 休憩時刻更新

			setDisplayShinkiKinmuhyoDateChooserYearAndMonth();	// 年月設定
		}

		//----------------------------------------------------------------------------------------------

		/** 勤務表新規作成ウィンドウを閉じる */
		private function closeWindowHandler(e:*):void {
			PopUpManager.removePopUp(view);
		}

		/** 勤務表作成 */
		private function kinmuhyoSakuseiHandler(e:MouseEvent):void {
			// 勤務表に反映
			var kinmuhyo:Kinmuhyo = Kinmuhyo.createDefaultKinmuhyo();
			var kinmuhyoShosai:KinmuhyoShosai;
			var shinkiKinmuhyoShosaiAC:ArrayCollection = new ArrayCollection();

			var year:int = view.shinkiKinmuhyoDateChooser.displayedYear;
			var month:int = view.shinkiKinmuhyoDateChooser.displayedMonth;
			var shigyoJikanItem:Object = view.shigyoJikanComboBox.selectedItem;
			var shigyoJikan:String;
			var shigyoJikanchi:Number;
			if (shigyoJikanItem != null) {
				shigyoJikan = shigyoJikanItem.jikoku;
				shigyoJikanchi = shigyoJikanItem.jikokuchi;
			}
			var syuryoJikanItem:Object = view.shuryoJikanComboBox.selectedItem;
			var syuryoJikan:String;
			var syuryoJikanchi:Number;
			if (syuryoJikanItem != null) {
				 syuryoJikan = syuryoJikanItem.jikoku;
				 syuryoJikanchi = syuryoJikanItem.jikokuchi;
			}
			var kyukeiJikanItem:Object = view.kyukeiJikanComboBox.selectedItem;
			var kyukeiJikan:Number;
			if (kyukeiJikanItem != null) {
				 kyukeiJikan = view.kyukeiJikanComboBox.selectedItem.jikokuchi;
			}
			var sagyoGenba:String = view.sagyoGenba.text;
			var shinkiKinmuhyo:ShinkiKinmuhyo = ShinkiKinmuhyo.getInstance();

			var getsu:String = (month + 1).toString();

			// 月が１０以下の場合「０」を足す
			if (month < 10) {
				getsu = 0 + getsu;
			}

			// 勤務表設定 ---------------------------------------------
			// 年月設定
			kinmuhyo.nengetsu = year + "-" + getsu;
			shinkiKinmuhyo.nengetsu = kinmuhyo.nengetsu;
			model.kinmuhyo = kinmuhyo;
			// 作業現場設定
			if (sagyoGenba != "undefined") {
				shinkiKinmuhyo.sagyoGenba = sagyoGenba;
				kinmuhyo.sagyoGenba = sagyoGenba;
			}

			// 勤務表詳細設定 ---------------------------------------------
			var date:Date = new Date();
			date.setFullYear(year, month, 1);

			var currentMonth:int = date.getMonth();
			for (var hizuke:int=1; hizuke < 32; hizuke++) {
				date.setFullYear(year, month, hizuke);
				if (date.getMonth() != currentMonth) {
					break;
				}
				kinmuhyoShosai = KinmuhyoShosai.createDefaultKinmuhyoShosai();
				kinmuhyoShosai.nengetsu = shinkiKinmuhyo.nengetsu;	// 年月設定
				kinmuhyoShosai.hizuke = new Date(year, month, hizuke);	// 日付設定

				// 始業時間設定
				if (isUpdatedShigyoJikan) {
					kinmuhyoShosai.shigyoJikan = shinkiKinmuhyo.shigyoJikan;
					kinmuhyoShosai.shigyoJikanchi = shinkiKinmuhyo.shigyoJikanchi;
				}
				// 終了時間設定
				if (isUpdatedSyuryoJikan) {
					kinmuhyoShosai.syuryoJikan = shinkiKinmuhyo.syuryoJikan;
					kinmuhyoShosai.syuryoJikanchi = shinkiKinmuhyo.syuryoJikanchi;
				}
				// 休憩時間設定
				if (isUpdatedKyukeiJikan) {
					kinmuhyoShosai.kyukeiJikan = shinkiKinmuhyo.kyukeiJikan;
				}
				// 実働時間計算
				if (isUpdatedShigyoJikan && isUpdatedSyuryoJikan && isUpdatedKyukeiJikan) {
					kinmuhyoShosai.jitsudoJikan = syuryoJikanchi - shigyoJikanchi - kyukeiJikan;
				}

				shinkiKinmuhyoShosaiAC.addItem(kinmuhyoShosai);
			}
			model.kinmuhyoShosaiAC = shinkiKinmuhyoShosaiAC;

			view.dispatchEvent(new KinmuhyoEvent(KinmuhyoEvent.KINMUHYO_SHINKI_SAKUSEI));
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
					isUpdatedShigyoJikan = true;
					break;
				case "shuryoJikanComboBox":
					model.shinkiKinmuhyo.syuryoJikan = jikoku;
					model.shinkiKinmuhyo.syuryoJikanchi = jikokuchi;
					isUpdatedSyuryoJikan = true;
					break;
				case "kyukeiJikanComboBox":
					model.shinkiKinmuhyo.kyukeiJikan = jikokuchi;
					isUpdatedKyukeiJikan = true;
					break;
			}
		}
		/** 時間ComboBox Label Function */
		public function kyukeiJikanComboBoxLabelFunction(item:Object):String {
			var kyukeiJikan:Number = item.jikokuchi as Number;
			return kyukeiJikan + " 時間";
		}

		/** 年月設定 */
		public function setDisplayShinkiKinmuhyoDateChooserYearAndMonth():void {
			/*
			var nengetsuArray:Array = model.shinkiKinmuhyo.nengetsu.split("-");
			view.shinkiKinmuhyoDateChooser.displayedYear = nengetsuArray[0];
			view.shinkiKinmuhyoDateChooser.displayedMonth = nengetsuArray[1];
			*/
		}
	}
}