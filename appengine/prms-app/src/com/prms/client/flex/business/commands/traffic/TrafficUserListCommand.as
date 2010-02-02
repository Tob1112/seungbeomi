package com.prms.client.flex.business.commands.traffic {
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.prms.client.flex.business.delegates.TrafficDelegate;
	import com.prms.client.flex.business.events.traffic.TrafficUserListEvent;
	import com.prms.client.flex.model.TrafficModelLocator;
	import com.prms.client.flex.util.Message;
	import com.prms.client.flex.views.traffic.user.UserTrafficList;
	import com.prms.client.flex.vo.Traffic;

	import mx.collections.ArrayCollection;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;

	public class TrafficUserListCommand implements ICommand {

        private var document:UserTrafficList;
        private var model:TrafficModelLocator = TrafficModelLocator.getInstance();
		private var dateMM:String = null;

		public function execute(event:CairngormEvent):void {

			document = (event as TrafficUserListEvent).doc;
			var responder:Responder = new Responder(TrafficListResultHandler, TrafficListFaultHandler);
			var delegate:TrafficDelegate = new TrafficDelegate(responder);
			delegate.trafficUserList();
		}

		private function TrafficListResultHandler(event:ResultEvent):void {

			model.trafficUserListAC = event.result as ArrayCollection;

			this.document.trafficListDataGrid.dataProvider = this.model.trafficUserListAC;
		}

		private function TrafficListFaultHandler(event:FaultEvent):void {
            //Alert.show(Message.SERVER_ACCESS_ERROR_MESSAGE);
            Message.showErrorMessage(event);
		}
	}
}