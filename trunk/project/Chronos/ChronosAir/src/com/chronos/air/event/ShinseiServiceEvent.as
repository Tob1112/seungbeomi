package com.chronos.air.event {

	import com.adobe.cairngorm.control.CairngormEvent;

	public class ShinseiServiceEvent extends CairngormEvent {

		public static const LOGIN:String = "login";
		public static const LOGOUT:String = "logout";

		public var view:Object;

		public function ShinseiServiceEvent(type:String, doc:Object=null) {
			super(type);
			view = doc;
		}

	}
}