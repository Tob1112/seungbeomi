package com.prms.client.flex.views.traffic.common.handlers
{
	import com.prms.client.flex.Constants;
	import com.prms.client.flex.business.events.traffic.TrafficIrregAffairsEvent;
	import com.prms.client.flex.business.events.traffic.TrafficTotalEvent;
	import com.prms.client.flex.model.TrafficModelLocator;
	import com.prms.client.flex.util.ViewStackChangeController;
	import com.prms.client.flex.views.traffic.user.UserTrafficIrregAffairs;
	import com.prms.client.flex.vo.Traffic;

	import flash.events.MouseEvent;

	import mx.core.IMXMLObject;
	import mx.events.FlexEvent;

	public class UserTrafficIrregAffairsHandler implements IMXMLObject{

		private var document:UserTrafficIrregAffairs;
		private var traffic:Traffic;

		[Bindable]
		public var model:TrafficModelLocator = TrafficModelLocator.getInstance();

		public function initialized(document:Object, id:String):void {
			this.document = document as UserTrafficIrregAffairs;
			this.document.addEventListener(FlexEvent.CREATION_COMPLETE, trafficirregAffairsHandler);
		}

		private function trafficirregAffairsHandler(event:FlexEvent):void {

            // 非定期業務分項目合計
            var totalEvent:TrafficIrregAffairsEvent = new TrafficIrregAffairsEvent(this.model.traffic, this.document);
            totalEvent.dispatch();

//			this.document.userTrafficRegularButton.addEventListener(MouseEvent.CLICKl trafficRegularTotalButtonClickHandler);
//			this.document.userTrafficIrregularButton.addEventListener(MouseEvent.CLICK, trafficRegularTotalButtonClickHandler);
//			this.document.userAffairsTrafficButton.addEventListener(MouseEvent.CLICK, trafficRegularTotalButtonClickHandler);
//			this.document.userAffairsTravelButton.addEventListener(MouseEvent.CLICK, trafficRegularTotalButtonClickHandler);

		}

        /**
         * 交通費一覧をダブルクリックした場合
         *
         */
        private function trafficRegularTotalButtonClickHandler(event:MouseEvent):void {

            // 勤務表詳細画面に移動
            ViewStackChangeController.viewstackChange(this.document.parentDocument, Constants.USER_TRAFFIC_DETAILS);
        }
	}
}