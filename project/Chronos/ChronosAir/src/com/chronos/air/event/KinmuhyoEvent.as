package com.chronos.air.event {

	import com.adobe.cairngorm.control.CairngormEvent;

	public class KinmuhyoEvent extends CairngormEvent {

		public static const KINMUHYO_SHINKI_SAKUSEI:String 	= "kinmuhyoEvent.kinmuhyoShinkiSakusei"; 	// 勤務表新規作成
		public static const GET_MAX_NENGETSU:String 		= "kinmuhyoEvent.getMaxNengetsu";			// 年月最大値
		public static const KINMUHYO_HOZON:String			= "kinmuhyoEvent.kinmuhyoHozon";			// 勤務表保存

		public var view:Object;

		public function KinmuhyoEvent(type:String, doc:Object=null) {
			super(type);
			view = doc;
		}
	}
}