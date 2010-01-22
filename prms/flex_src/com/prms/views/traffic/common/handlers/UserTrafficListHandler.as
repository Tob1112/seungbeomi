package com.prms.views.traffic.common.handlers {
	import com.prms.business.events.traffic.TrafficUserListEvent;
	import com.prms.views.traffic.user.UserTrafficList;
	import com.prms.vo.Traffic;

	import mx.core.IMXMLObject;
	import mx.events.FlexEvent;

	public class UserTrafficListHandler implements IMXMLObject{

		private var document:UserTrafficList;
		private var trafficVO:Traffic;

		public function initialized(document:Object, id:String):void {
			this.document = document as UserTrafficList;
			this.document.addEventListener(FlexEvent.CREATION_COMPLETE, trafficListHandler);
		}

		private function trafficListHandler(event:FlexEvent):void {

            // 交通費一覧ロード
            var listEvent:TrafficUserListEvent = new TrafficUserListEvent(trafficVO, this.document);
            listEvent.dispatch();

		}
	}
}