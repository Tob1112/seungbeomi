package com.chronos.air.view.controller
{
	import flash.events.Event;

	public class PopupEvent extends Event {

		public static const SHINKI_KINMUHYO_HANEI:String = "popupEvent.shinkiKinmuhyoHanei";	// 新規勤務表反映

		public function PopupEvent(type:String) {
			super(type);
		}

	}
}