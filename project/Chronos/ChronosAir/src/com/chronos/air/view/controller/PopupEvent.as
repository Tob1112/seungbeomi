package com.chronos.air.view.controller
{
	import flash.events.Event;

	public class PopupEvent extends Event {

		public static const KINMUHYO_SHINKI_SAKUSEI_WINDOW_CLOSE:String = "kinmuhyoShinkiSakuseiWindowClose";

		public function PopupEvent(type:String) {
			super(type);
		}

	}
}