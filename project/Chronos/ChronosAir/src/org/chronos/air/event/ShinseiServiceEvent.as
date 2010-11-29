package org.chronos.air.event {

	import com.adobe.cairngorm.control.CairngormEvent;

	public class ShinseiServiceEvent extends CairngormEvent {

		public static const LOGIN:String = "shinseiServiceEvent.login";
		public static const LOGOUT:String = "shinseiServiceEvent.logout";
		public static const SEND_KINMUHYO:String	= "shinseiServiceEvent.sendKinmuhyo";

		public var view:Object;

		public function ShinseiServiceEvent(type:String, doc:Object=null) {
			super(type);
			view = doc;
		}

	}
}