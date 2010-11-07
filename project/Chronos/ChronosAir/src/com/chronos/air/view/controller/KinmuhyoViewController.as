package com.chronos.air.view.controller {

	import com.chronos.air.event.KinmuhyoShinkiSakuseiEvent;
	import com.chronos.air.model.KinmuhyoModel;
	import com.chronos.air.util.CalendarUtil;
	import com.chronos.air.view.KinmuhyoShinkiSakuseiWindow;
	import com.chronos.air.view.KinmuhyoView;

	import flash.events.MouseEvent;

	import mx.core.IMXMLObject;
	import mx.events.DividerEvent;
	import mx.events.FlexEvent;
	import mx.managers.PopUpManager;

	public class KinmuhyoViewController implements IMXMLObject{

		private var view:KinmuhyoView;
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

			setCurrentDate();	// 現在の時刻を設定する。(2011年11月3日(水))
		}

		/** 現在の時刻を設定する。(2011年11月3日(水)) */
		private function setCurrentDate():void {
			var currentDate:Date = new Date();
			view.model.currentDate = CalendarUtil.currentDateLabel(currentDate);
		}

		/** メニュー表示＊非表示 */
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

			switch (e.currentTarget.name) {
			case "kinmuhyoDateChooser":
				year = view.kinmuhyoDateChooser.displayedYear;
				month = view.kinmuhyoDateChooser.displayedMonth;
				trace(new Date(year, month));
				break;
			}
		}

		/** 勤務表新規作成ウィンドウポップアップ */
		private function popupKinmuhyoShinkiSakuseiWindow(e:MouseEvent):void {
			var kinmuhyouShinkiSakuseiWindow:KinmuhyoShinkiSakuseiWindow
				= PopUpManager.createPopUp(view, KinmuhyoShinkiSakuseiWindow, true) as KinmuhyoShinkiSakuseiWindow;
			kinmuhyouShinkiSakuseiWindow.addEventListener(KinmuhyoShinkiSakuseiEvent.KINMUHYO_SHINKI_SAKUSEI, kinmuhyoShinkiSakuseiHandler);
			PopUpManager.centerPopUp(kinmuhyouShinkiSakuseiWindow);
		}

		private function kinmuhyoShinkiSakuseiHandler(e:KinmuhyoShinkiSakuseiEvent):void {
			trace("kinmuhyoShinkiSakuseiHandler");
		}

		/** 勤務表プレビュー */
		private function kinmuhyouPreviewHandler(e:MouseEvent):void {
			// TODO xml, xslを利用しプレビュー
		}
	}
}