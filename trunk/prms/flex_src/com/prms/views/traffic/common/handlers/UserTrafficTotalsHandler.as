package com.prms.views.traffic.common.handlers
{
	import com.prms.Constants;
	import com.prms.util.ViewStackChangeController;
	import com.prms.views.traffic.user.UserTrafficTotals;
	import com.prms.vo.Traffic;

	import flash.events.MouseEvent;

	import mx.core.IMXMLObject;
	import mx.events.FlexEvent;

	public class UserTrafficTotalsHandler implements IMXMLObject{

		private var document:UserTrafficTotals;
		private var trafficVO:Traffic;

		public function initialized(document:Object, id:String):void {
			this.document = document as UserTrafficTotals;
			this.document.addEventListener(FlexEvent.CREATION_COMPLETE, trafficTotalsHandler);
		}

		private function trafficTotalsHandler(event:FlexEvent):void {

			this.document.userRegDetailsImage.addEventListener(MouseEvent.CLICK, trafficTotalItemClickHandler);
			this.document.userIrregDetailsImage.addEventListener(MouseEvent.CLICK, trafficTotalItemClickHandler);

            // 交通費一覧ロード
//            var listEvent:TrafficUserListEvent = new TrafficUserListEvent(trafficVO, this.document);
//            listEvent.dispatch();
		}

        /**
         * 交通費一覧をダブルクリックした場合
         *
         */
        private function trafficTotalItemClickHandler(event:MouseEvent):void {

            // 勤務表詳細画面に移動
            ViewStackChangeController.viewstackChange(this.document.parentDocument, Constants.USER_TRAFFIC_DETAILS);

        }
	}
}