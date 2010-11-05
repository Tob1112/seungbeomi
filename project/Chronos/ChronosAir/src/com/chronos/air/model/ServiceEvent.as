package com.chronos.air.model {

	import com.adobe.cairngorm.control.CairngormEvent;

	public class ServiceEvent extends CairngormEvent {

		public static const LOGIN:String = "login";
		public static const LOGOUT:String = "logout";

		public var view:Object;

		public function ServiceEvent(type:String, doc:Object=null) {
			super(type);
			view = doc;
		}

	}
}