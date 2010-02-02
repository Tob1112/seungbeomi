package com.prms.client.flex.business.events.traffic {
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.prms.client.flex.views.traffic.user.UserTrafficIrregAffairs;
	import com.prms.client.flex.vo.Traffic;

	public class TrafficIrregAffairsEvent extends CairngormEvent {

		public static var EVENT_ID:String = "trafficIrregAffairsEvent";
		public var traffic:Traffic;
		public var doc:UserTrafficIrregAffairs;

		public function TrafficIrregAffairsEvent(traffic:Traffic, doc:UserTrafficIrregAffairs) {
			super(EVENT_ID);
			this.traffic = traffic;
			this.doc = doc;
		}
	}
}