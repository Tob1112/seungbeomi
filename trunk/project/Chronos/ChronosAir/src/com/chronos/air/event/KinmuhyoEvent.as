package com.chronos.air.event {

	import com.adobe.cairngorm.control.CairngormEvent;

	public class KinmuhyoEvent extends CairngormEvent {

		public static const KINMUHYO_SHINKI_SAKUSEI:String = "kinmuhyoShinkiSakusei";
		public static const FIND_SHINKI_NENGETSU:String = "findShinkiNengetsu";

		public var view:Object;

		public function KinmuhyoEvent(type:String, doc:Object=null) {
			super(type);
			view = doc;
		}
	}
}