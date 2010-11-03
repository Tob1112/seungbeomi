package com.chronos.air.controller {

	import com.chronos.air.model.KinmuhyoModelLocator;
	import com.chronos.air.util.CalendarUtil;
	import com.chronos.air.view.KinmuhyoView;

	import mx.core.IMXMLObject;
	import mx.events.DividerEvent;
	import mx.events.FlexEvent;

	public class KinmuhyoController implements IMXMLObject{

		private var view:KinmuhyoView;
		public var model:KinmuhyoModelLocator = KinmuhyoModelLocator.getInstance();

		private static const SHOW_MENU_STATE:String = "showMenu";
		private static const HIDE_MENU_STATE:String = "hideMenu";

		public function initialized(doc:Object, id:String):void {
			view = doc as KinmuhyoView;
			view.addEventListener(FlexEvent.CREATION_COMPLETE, creationCompletHandler);
		}

		public function creationCompletHandler(e:FlexEvent):void {
			// イベント登録
			view.kinmuhyoDividedBox.addEventListener(DividerEvent.DIVIDER_RELEASE, menuBoxToggleHandler);
			// 現在の時刻を設定する。(2011年11月3日(水))
			setCurrentDate();
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

	}
}