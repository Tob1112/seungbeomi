package org.chronos.air.event {

	import com.adobe.cairngorm.control.CairngormEvent;

	public class KinmuhyoEvent extends CairngormEvent {

		public static const KINMUHYO_SHINKI_SAKUSEI:String 	= "kinmuhyoEvent.kinmuhyoShinkiSakusei"; 	// 勤務表新規作成
		public static const FIND_MAX_NENGETSU:String 		= "kinmuhyoEvent.findMaxNengetsu";			// 年月最大値
		public static const SAVE_KINMUHYO:String			= "kinmuhyoEvent.saveKinmuhyo";				// 勤務表保存
		public static const UPDATED_KINMUHYO:String			= "kinmuhyoEvent.updatedKinmuhyo";			// 勤務表更新
		public static const FIND_KINMUHYO_SHOSAI:String		= "kinmuhyoEvent.findKinmuhyoShosai";		// 勤務表詳細検索

		public var view:Object;

		public function KinmuhyoEvent(type:String, doc:Object=null) {
			super(type);
			view = doc;
		}
	}
}