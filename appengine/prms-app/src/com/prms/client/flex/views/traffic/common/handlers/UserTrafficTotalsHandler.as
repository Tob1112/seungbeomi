package com.prms.client.flex.views.traffic.common.handlers
{
	import com.prms.client.flex.Constants;
	import com.prms.client.flex.business.events.traffic.TrafficTotalEvent;
	import com.prms.client.flex.model.TrafficModelLocator;
	import com.prms.client.flex.util.ViewStackChangeController;
	import com.prms.client.flex.views.traffic.user.UserTrafficTotals;
	import com.prms.client.flex.vo.Traffic;

	import flash.events.MouseEvent;

	import mx.core.IMXMLObject;
	import mx.events.FlexEvent;

	public class UserTrafficTotalsHandler implements IMXMLObject{

		private var document:UserTrafficTotals;
		private var traffic:Traffic;

		[Bindable]
		public var model:TrafficModelLocator = TrafficModelLocator.getInstance();

		public function initialized(document:Object, id:String):void {
			this.document = document as UserTrafficTotals;
			this.document.addEventListener(FlexEvent.CREATION_COMPLETE, trafficTotalsHandler);
		}

		private function trafficTotalsHandler(event:FlexEvent):void {

			this.document.userTrafficRegularButton.addEventListener(MouseEvent.CLICK, trafficRegularTotalButtonClickHandler);
			this.document.userTrafficIrregularButton.addEventListener(MouseEvent.CLICK, trafficRegularTotalButtonClickHandler);
			this.document.userAffairsTrafficButton.addEventListener(MouseEvent.CLICK, trafficRegularTotalButtonClickHandler);
			this.document.userAffairsTravelButton.addEventListener(MouseEvent.CLICK, trafficRegularTotalButtonClickHandler);

            // 交通費合計
            var totalEvent:TrafficTotalEvent = new TrafficTotalEvent(this.model.traffic, this.document);
            totalEvent.dispatch();
		}

        /**
         * 交通費一覧をダブルクリックした場合
         *
         */
        private function trafficRegularTotalButtonClickHandler(event:MouseEvent):void {

            // 勤務表詳細画面に移動
            ViewStackChangeController.viewstackChange(this.document.parentDocument, Constants.USER_TRAFFIC_DETAILS);
        }

        /**
         * 交通費一覧をダブルクリックした場合
         *
         */
//        private function trafficIrregularButtonClickHandler(event:MouseEvent):void {
//
//            // 勤務表詳細画面に移動
//            ViewStackChangeController.viewstackChange(this.document.parentDocument, Constants.USER_TRAFFIC_IRREGULAR);
//        }
	}
}