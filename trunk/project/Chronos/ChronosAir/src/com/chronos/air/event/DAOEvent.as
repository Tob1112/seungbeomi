package com.chronos.air.event {

	import com.adobe.cairngorm.control.CairngormEvent;

	public class DAOEvent extends CairngormEvent {

		public static const OPEN_DATABASE:String 	= "openDatabase";
		public static const SAVE_SHAIN:String 		= "saveShain";
		public static const FIND_KINMUHYO:String 	= "findKinmuhyo";
		public static const FIND_MAX_NENGETSU:String= "findMaxNengetsu";
		//public static const FIND_JIKOKUHYO:String	= "findJikokuhyo";
		public static const INITIALIZE_DATA:String 	= "daoEvent.initializeData";

		public function DAOEvent(type:String) {
			super(type);
		}
	}
}