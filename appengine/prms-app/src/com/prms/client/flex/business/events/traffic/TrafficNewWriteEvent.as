package com.prms.client.flex.business.events.traffic {
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.prms.client.flex.views.traffic.user.UserTrafficList;
	import com.prms.client.flex.vo.Traffic;

	public class TrafficNewWriteEvent extends CairngormEvent {

		static public var EVENT_ID:String = "trafficNewWriteEvent";
		public var doc:UserTrafficList;
		public var traffic:Traffic;

		public function TrafficNewWriteEvent(traffic:Traffic, doc:UserTrafficList) {
			super(EVENT_ID);
			this.traffic = traffic;
			this.doc = doc;
		}
	}
}