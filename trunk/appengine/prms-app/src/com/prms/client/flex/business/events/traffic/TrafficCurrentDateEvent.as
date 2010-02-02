package com.prms.client.flex.business.events.traffic {
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.prms.client.flex.views.traffic.user.UserTrafficList;

	public class TrafficCurrentDateEvent extends CairngormEvent {

		static public var EVENT_ID:String = "trafficCurrentDateEvent";
		public var doc:UserTrafficList;

		public function TrafficCurrentDateEvent(doc:UserTrafficList) {
			super(EVENT_ID);
			this.doc = doc;
		}
	}
}