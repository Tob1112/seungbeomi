package com.prms.business.events.traffic {
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.prms.views.traffic.user.UserTrafficList;

	public class TrafficUserListEvent extends CairngormEvent {

		static public var EVENT_ID:String = "trafficUserListEvent";
		public var doc:UserTrafficList;

		public function TrafficUserListEvent(doc:UserTrafficList) {
			super(EVENT_ID);
			this.doc = doc;
		}
	}
}