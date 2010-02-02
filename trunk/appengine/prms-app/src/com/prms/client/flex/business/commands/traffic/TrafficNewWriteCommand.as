package com.prms.client.flex.business.commands.traffic {
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.prms.client.flex.Constants;
	import com.prms.client.flex.business.delegates.TrafficDelegate;
	import com.prms.client.flex.business.events.traffic.TrafficNewWriteEvent;
	import com.prms.client.flex.model.TrafficModelLocator;
	import com.prms.client.flex.util.Message;
	import com.prms.client.flex.util.ViewStackChangeController;
	import com.prms.client.flex.views.traffic.user.UserTrafficList;

	import mx.controls.Alert;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;

	public class TrafficNewWriteCommand implements ICommand {

        private var document:UserTrafficList;
        private var model:TrafficModelLocator = TrafficModelLocator.getInstance();

		public function execute(event:CairngormEvent):void {

			document = (event as TrafficNewWriteEvent).doc;
			var responder:Responder = new Responder(TrafficNewWriteResultHandler, TrafficNewWriteFaultHandler);
			var delegate:TrafficDelegate = new TrafficDelegate(responder);
			delegate.trafficNewWrite((event as TrafficNewWriteEvent).traffic);
		}

		private function TrafficNewWriteResultHandler(event:ResultEvent):void {

			if(event.result == true)
			{
				Alert.show("選択した日付の交通費作成されています。日付を確認してください。");
			}
			else
			{
            	// 勤務表詳細画面に移動
            	ViewStackChangeController.viewstackChange(this.document.parentDocument, Constants.USER_TRAFFIC_DETAILS);
			}
		}

		private function TrafficNewWriteFaultHandler(event:FaultEvent):void {
            //Alert.show(Message.SERVER_ACCESS_ERROR_MESSAGE);
            Message.showErrorMessage(event);
		}
	}
}