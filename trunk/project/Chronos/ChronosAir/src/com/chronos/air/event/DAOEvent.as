package com.chronos.air.event {

	import com.adobe.cairngorm.control.CairngormEvent;

	public class DAOEvent extends CairngormEvent {

		public static const OPEN_DATABASE:String 	= "openDatabase";
		public static const SAVE_USER:String 		= "saveUser";
		public static const REMOVE_USER:String 		= "removeUser";

		public var view:Object;

		public function DAOEvent(type:String, doc:Object=null) {
			super(type);
			view = doc;
		}
	}
}