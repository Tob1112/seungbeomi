package com.prms.client.flex.business.events.traffic {
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.prms.client.flex.views.traffic.user.UserTrafficTotals;
	import com.prms.client.flex.vo.Traffic;

	public class TrafficTotalEvent extends CairngormEvent {

		public static var EVENT_ID:String = "trafficTotalEvent";
		public var traffic:Traffic;
		public var doc:UserTrafficTotals;

		public function TrafficTotalEvent(traffic:Traffic, doc:UserTrafficTotals) {
			super(EVENT_ID);
			this.traffic = traffic;
			this.doc = doc;
		}
	}
}