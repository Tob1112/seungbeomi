package com.chronos.air.view.controller {

	import com.chronos.air.common.LabelUtil;
	import com.chronos.air.event.KinmuhyoEvent;
	import com.chronos.air.model.Kinmuhyo;
	import com.chronos.air.model.KinmuhyoModel;
	import com.chronos.air.model.ShinkiKinmuhyo;
	import com.chronos.air.model.ShinseiJokyoEnum;
	import com.chronos.air.util.CalendarUtil;
	import com.chronos.air.util.Logger;
	import com.chronos.air.view.KinmuhyoShinkiSakuseiWindow;
	import com.chronos.air.view.KinmuhyoView;

	import flash.display.NativeWindowInitOptions;
	import flash.display.NativeWindowSystemChrome;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.html.HTMLLoader;

	import mx.controls.dataGridClasses.DataGridColumn;
	import mx.core.IMXMLObject;
	import mx.events.DataGridEvent;
	import mx.events.DividerEvent;
	import mx.events.FlexEvent;
	import mx.events.ListEvent;
	import mx.managers.PopUpManager;

	public class KinmuhyoViewController implements IMXMLObject{

		private var view:KinmuhyoView;
		[Bindable]
		public var model:KinmuhyoModel = KinmuhyoModel.getInstance();

		private static const SHOW_MENU_STATE:String = "showMenu";
		private static const HIDE_MENU_STATE:String = "hideMenu";

		public function initialized(doc:Object, id:String):void {
			view = doc as KinmuhyoView;
			view.addEventListener(FlexEvent.CREATION_COMPLETE, creationCompletHandler);
		}

		public function creationCompletHandler(e:FlexEvent):void {
			// イベント登録
			//view.kinmuhyoDividedBox.addEventListener(DividerEvent.DIVIDER_RELEASE, menuBoxToggleHandler);	// メニューのトグル機能
			view.kinmuhyoDateChooser.addEventListener(MouseEvent.CLICK, findKinmuhyoHandler);	// DateChooserから年月を取得し、勤務表を検索
			view.kinmuhyoShinkiSakuseiButton.addEventListener(MouseEvent.CLICK, popupKinmuhyoShinkiSakuseiWindow);	// 勤務表新規作成
			view.kinmuhyoPreviewButton.addEventListener(MouseEvent.CLICK, kinmuhyouPreviewHandler);	// 勤務表プレビュー
			view.kinmuhyoList.addEventListener(ListEvent.CHANGE, kinmuhyoListClickHandler);	// 勤務表リストクリック
			view.saveKinmuhyoButton.addEventListener(MouseEvent.CLICK, saveKinmuhyoHandler);	// 勤務表保存

			//view.kinmuhyoShosaiDataGrid.addEventListener(ListEvent.CHANGE, jikokuHenkoHandler);
			view.kinmuhyoShosaiDataGrid.addEventListener(DataGridEvent.ITEM_EDIT_BEGIN, jikokuKoushinKaishiHandler);
			view.kinmuhyoShosaiDataGrid.addEventListener(DataGridEvent.ITEM_EDIT_END, jikokuKoushinShuryoHandler);
			setCurrentDate();	// 現在の時刻を設定する。(2011年11月3日(水))
		}

		/** 現在の時刻を設定する。(2011年11月3日(水)) */
		private function setCurrentDate():void {
			var currentDate:Date = new Date();
			//view.model.currentDate = CalendarUtil.currentDateLabel(currentDate);
			model.currentDate = CalendarUtil.currentDateLabel(currentDate);
		}

		/** メニュー表示/非表示 */
		private function menuBoxToggleHandler(e:DividerEvent):void {
			if (view.currentState == SHOW_MENU_STATE) {
				view.currentState = HIDE_MENU_STATE;
			} else {
				view.currentState = SHOW_MENU_STATE;
			}
		}

		/** DateChooserから年月を取得し、勤務表を検索  */
		private function findKinmuhyoHandler(e:MouseEvent):void {
			var year:int = 0;
			var month:int = 0;
			var getsu:String = "";
			var nengetsu:String;

			switch (e.currentTarget.name) {
			case "kinmuhyoDateChooser":
				year = view.kinmuhyoDateChooser.displayedYear;
				month = view.kinmuhyoDateChooser.displayedMonth + 1;

				if (month < 10) {
					getsu = "0" + month;
				} else {
					getsu = month.toString();
				}

				// 勤務表リストと勤務表詳細と同期
				nengetsu = year + "-" + getsu;
				findKinmuhyoShosai(nengetsu);
				break;
			}
		}

		/** 勤務表新規作成ウィンドウポップアップ */
		private function popupKinmuhyoShinkiSakuseiWindow(e:MouseEvent):void {
			// 勤務表年月最大値取得
			var event:KinmuhyoEvent = new KinmuhyoEvent(KinmuhyoEvent.FIND_MAX_NENGETSU, view);
			event.dispatch();

			// 勤務表年月最大値を作業年月に設定
			var sagyoNengetsu:String = ShinkiKinmuhyo.getInstance().nengetsu;
			var sagyoNengetsuArray:Array = sagyoNengetsu.split("-");

			// 勤務表新規作成ウィンドウポップアップ
			var kinmuhyouShinkiSakuseiWindow:KinmuhyoShinkiSakuseiWindow
					= PopUpManager.createPopUp(view, KinmuhyoShinkiSakuseiWindow, true) as KinmuhyoShinkiSakuseiWindow;
			kinmuhyouShinkiSakuseiWindow.addEventListener(KinmuhyoEvent.KINMUHYO_SHINKI_SAKUSEI, kinmuhyoShinkiSakuseiHandler);	// 勤務表新規作成
			//kinmuhyouShinkiSakuseiWindow.controller.model.shinkiKinmuhyo.nengetsu = sagyoNengetsu;

			if (sagyoNengetsu != "") {
				kinmuhyouShinkiSakuseiWindow.shinkiKinmuhyoDateChooser.displayedYear = sagyoNengetsuArray[0];
				kinmuhyouShinkiSakuseiWindow.shinkiKinmuhyoDateChooser.displayedMonth = sagyoNengetsuArray[1];
			}

			PopUpManager.centerPopUp(kinmuhyouShinkiSakuseiWindow);
		}

		/** 勤務表新規作成 */
		private function kinmuhyoShinkiSakuseiHandler(e:KinmuhyoEvent):void {
			// 勤務表設定
			var nengetsu:String = model.kinmuhyo.nengetsu;
			var nengetsuArray:Array = nengetsu.split("-");
			var year:int = nengetsuArray[0];
			var month:int = nengetsuArray[1];

			view.kinmuhyoDateChooser.displayedYear = year;
			view.kinmuhyoDateChooser.displayedMonth = month - 1;

			// 保存可能状態に更新
			view.currentState = "updateKinmuhyo";
			model.isPersisted = false;

		}

		/** 勤務表プレビュー */
		private function kinmuhyouPreviewHandler(e:MouseEvent):void {
			// TODO xml, xslを利用しプレビュー
			var html:HTMLLoader = new HTMLLoader();
			var options:NativeWindowInitOptions = new NativeWindowInitOptions();
			options.systemChrome = NativeWindowSystemChrome.STANDARD;
			options.type = "normal";
			var windowBounds:Rectangle = new Rectangle(0,0,300,300);
			html = HTMLLoader.createRootWindow(true, options, true, windowBounds);
			html.loadString("<html><body><h1>Hello Chronos!!</h1></body></html>");
			//view.stage.addChild(html);
		}

		/** 勤務表リストから申請アイテム選択時、該当勤務表取得 */
		private function kinmuhyoListClickHandler(e:ListEvent):void {
			var nengetsu:String = Kinmuhyo(e.currentTarget.selectedItem).nengetsu;
			findKinmuhyoShosai(nengetsu);	// 勤務表詳細検索
		}

		private function jikokuKoushinKaishiHandler(e:DataGridEvent):void {

			Logger.log(e.itemRenderer.data.shigyoJikan);
		}

		private function jikokuKoushinShuryoHandler(e:DataGridEvent):void {

		}

		/** 勤務表保存 */
		private function saveKinmuhyoHandler(e:MouseEvent):void {
			var event:KinmuhyoEvent = new KinmuhyoEvent(KinmuhyoEvent.SAVE_KINMUHYO);
			event.dispatch();
		}

		private function findKinmuhyoShosai(nengetsu:String):void {
			model.nengetsu = nengetsu;	// 検索のため

			var event:KinmuhyoEvent = new KinmuhyoEvent(KinmuhyoEvent.FIND_KINMUHYO_SHOSAI, view);
			event.dispatch();
		}

		// LABEL FUNCTION -----------------------------------------------------------------------------
		/** 勤務表リストLabelFunction */
		public function shinseiListLabelFunction(item:Object):String {
			var nengetsu:String = Kinmuhyo(item).nengetsu;
			var code:String = Kinmuhyo(item).shinseiJokyo;
			return LabelUtil.nengetsuLabel(nengetsu)  + " " + ShinseiJokyoEnum.fromCode(code);
		}
		/** 休み区分LabelFuntion */
		public function yasumiKubunLabelFunction(item:Object, data:DataGridColumn):String {

			// TODO コードを休み区分に変更

			Logger.log("休み区分："+ item.yasumiKubun);
			return item.yasumiKubun;
		}
		/** 休憩時間LabelFunction */
		public function kyukeiJikanLabelFunction(item:Object, data:DataGridColumn):String {
			var result:String;
			if (item.kyukeiJikan != 0) {
				result = item.kyukeiJikan + " 時間";
			} else {
				result = "";
			}
			return result;
		}
	}
}