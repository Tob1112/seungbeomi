package com.prms.client.flex.business.events.traffic
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.prms.client.flex.views.traffic.user.UserTrafficRegOther;
	import com.prms.client.flex.vo.TrafficRegular;

	public class LoadRegOtherListEvent extends CairngormEvent{

		static public var EVENT_ID:String = "loadRegOtherListEvent";
		public var trafficRegular:TrafficRegular;
		public var document:UserTrafficRegOther;

		public function LoadRegOtherListEvent(trafficRegular:TrafficRegular):void{
			super(EVENT_ID);
			this.trafficRegular = trafficRegular;
		}

	}
}