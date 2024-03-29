package com.prms.business.events.traffic
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.prms.views.traffic.user.UserTrafficRegTrain;
	import com.prms.vo.TrafficRegular;

	public class LoadRegTrainListEvent extends CairngormEvent{

		static public var EVENT_ID:String = "loadRegTrainListEvent";
		public var trafficRegular:TrafficRegular;
		public var document:UserTrafficRegTrain;

		public function LoadRegTrainListEvent(trafficRegular:TrafficRegular){
			super(EVENT_ID);
			this.trafficRegular = trafficRegular;
		}

	}
}