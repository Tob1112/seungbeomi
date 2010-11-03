package com.chronos.air.model {

	import com.adobe.cairngorm.control.CairngormEvent;

	public class MainEvent extends CairngormEvent {

		public static const LOGIN:String = "login";

		public var view:Object;

		public function MainEvent(type:String, doc:Object=null) {
			super(type);
			view = doc;
		}
	}
}