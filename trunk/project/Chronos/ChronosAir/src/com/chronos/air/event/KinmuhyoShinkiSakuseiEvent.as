package com.chronos.air.event {

	import flash.events.Event;

	public class KinmuhyoShinkiSakuseiEvent extends Event {

		public static const KINMUHYO_SHINKI_SAKUSEI:String = "kinmuhyoShinkiSakusei";

		public function KinmuhyoShinkiSakuseiEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
		}

	}
}