package com.chronos.air.event {

	import com.adobe.cairngorm.control.CairngormEvent;

	public class KinmuhyoEvent extends CairngormEvent {

		public static const KINMUHYO_SHINKI_SAKUSEI:String = "kinmuhyoShinkiSakusei";
		public static const GET_MAX_NENGETSU:String = "getMaxNengetsu";
		public static const GET_JIKOKUHYO:String = "getJikokuhyo";

		public var view:Object;

		public function KinmuhyoEvent(type:String, doc:Object=null) {
			super(type);
			view = doc;
		}
	}
}