package com.prms.business.events.traffic {
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.prms.views.traffic.user.UserTrafficList;
	import com.prms.vo.Traffic;

	public class TrafficUserListEvent extends CairngormEvent {

		static public var EVENT_ID:String = "trafficUserListEvent";
		public var trafficVO:Traffic;
		public var doc:UserTrafficList;

		public function TrafficUserListEvent(trafficVO:Traffic, doc:UserTrafficList) {

			super(EVENT_ID);
			this.trafficVO = trafficVO;
			this.doc = doc;

		}
	}
}