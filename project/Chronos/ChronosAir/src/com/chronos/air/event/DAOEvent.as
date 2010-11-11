package com.chronos.air.event {

	import com.adobe.cairngorm.control.CairngormEvent;

	public class DAOEvent extends CairngormEvent {

		public static const SAVE_SHAIN:String 			= "daoEvent.saveShain";			// 社員保存
		public static const FIND_KINMUHYO:String 		= "daoEvent.findKinmuhyo";		// 勤務表検索
		public static const FIND_MAX_NENGETSU:String	= "daoEvent.findMaxNengetsu";	// 年月最大値検索
		public static const FIND_JIKOKUHYO:String		= "daoEvent.findJikokuhyo";		// 時刻表検索
		public static const FIND_CODE_DATA:String 		= "daoEvent.findCodeData";		// コードデータ検索
		public static const KINMUHYO_HOZON:String		= "daoEvent.kinmuhyoHozon";		// 勤務表保存

		public function DAOEvent(type:String) {
			super(type);
		}
	}
}