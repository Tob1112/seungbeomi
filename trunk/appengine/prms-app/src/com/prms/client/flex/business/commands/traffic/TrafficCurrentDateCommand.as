package com.prms.client.flex.business.commands.traffic {
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.prms.client.flex.business.delegates.TrafficDelegate;
	import com.prms.client.flex.business.events.traffic.TrafficCurrentDateEvent;
	import com.prms.client.flex.model.TrafficModelLocator;
	import com.prms.client.flex.util.Message;
	import com.prms.client.flex.views.traffic.user.UserTrafficList;
	import com.prms.client.flex.vo.Traffic;

	import mx.formatters.DateFormatter;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;

	public class TrafficCurrentDateCommand implements ICommand {

		private var document:UserTrafficList;
		private var model:TrafficModelLocator = TrafficModelLocator.getInstance();

		public function execute(event:CairngormEvent):void {

			document = (event as TrafficCurrentDateEvent).doc;
			var responder:Responder = new Responder(TrafficCurrentDateResultHandler, TrafficCurrentDateFaultHandler);
			var delegate:TrafficDelegate = new TrafficDelegate(responder);
			delegate.trafficCurrentDate();
		}

		private function TrafficCurrentDateResultHandler(event:ResultEvent):void {

			model.traffic = event.result as Traffic;

			// デートフォーマット
			var formatter:DateFormatter = new DateFormatter();

			formatter.formatString = "YYYY年 MM月 DD日 ( EEEE )";

			// 現在日付を表示する。
			this.document.currentDateLabel.text = formatter.format( model.traffic.currentDate );

		    // 新規作成入力フォーム
			this.document.trafficListYearTextInput.text = model.traffic.currentDate.getFullYear().toString();
			this.document.trafficListMonthTextInput.text = model.traffic.currentDate.getMonth().toString() +1;
		}

		private function TrafficCurrentDateFaultHandler(event:FaultEvent):void {
			//Alert.show(Message.SERVER_ACCESS_ERROR_MESSAGE);
			Message.showErrorMessage(event);
		}
	}
}