package com.prms.client.flex.business.commands.traffic {
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.prms.client.flex.business.delegates.TrafficDelegate;
	import com.prms.client.flex.business.events.traffic.TrafficIrregAffairsEvent;
	import com.prms.client.flex.model.TrafficModelLocator;
	import com.prms.client.flex.util.Message;
	import com.prms.client.flex.views.traffic.user.UserTrafficIrregAffairs;
	import com.prms.client.flex.vo.TrafficIrregular;

	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;

	public class TrafficIrregAffairsCommand implements ICommand {

		private var document:UserTrafficIrregAffairs;
		private var model:TrafficModelLocator = TrafficModelLocator.getInstance();

		public function execute(event:CairngormEvent):void {

			document = (event as TrafficIrregAffairsEvent).doc;
			var responder:Responder = new Responder(TrafficIrregAffairsResultHandler, TrafficIrregAffairsFaultHandler);
			var delegate:TrafficDelegate = new TrafficDelegate(responder);
			delegate.trafficIrregAffairs((event as TrafficIrregAffairsEvent).traffic);
		}

		private function TrafficIrregAffairsResultHandler(event:ResultEvent):void {

			model.trafficIrregAffair = event.result as TrafficIrregular;
			var affairsTotal:Number = 0;

			// 検索データがない場合
			if (event.result == null)
			{

			}
			// 検索データがある場合
			else
			{
				// 交通費非定期業務分合計
				affairsTotal =
					model.trafficIrregAffair.trainFare +	// 電車代
					model.trafficIrregAffair.taxiFare +		// タクシー代
					model.trafficIrregAffair.busFare + 		// バス代
					model.trafficIrregAffair.hotelFare + 	// 宿泊費
					model.trafficIrregAffair.otherFare;		// その他
			}

			// 交通費非定期業務分合計を表示する。
			document.affairsTotalLabel.text = affairsTotal.toString();

		}

		private function TrafficIrregAffairsFaultHandler(event:FaultEvent):void {
			//Alert.show(Message.SERVER_ACCESS_ERROR_MESSAGE);
			Message.showErrorMessage(event);
		}
	}
}