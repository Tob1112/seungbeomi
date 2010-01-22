package com.prms.business.commands.traffic {
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.prms.business.delegates.TrafficDelegate;
	import com.prms.business.events.traffic.TrafficUserListEvent;
	import com.prms.model.TrafficModelLocator;
	import com.prms.util.Message;
	import com.prms.views.traffic.user.UserTrafficList;

	import mx.collections.ArrayCollection;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;

	public class TrafficUserListCommand implements ICommand {

        private var document:UserTrafficList;
        private var model:TrafficModelLocator = TrafficModelLocator.getInstance();

		public function execute(event:CairngormEvent):void {

			document = (event as TrafficUserListEvent).doc;
			var responder:Responder = new Responder(TrafficListResultHandler, TrafficListFaultHandler);
			var delegate:TrafficDelegate = new TrafficDelegate(responder);
			delegate.trafficUserList();
		}

		private function TrafficListResultHandler(event:ResultEvent):void {

			model.trafficUserListAC = event.result as ArrayCollection;

			for (var i:int = 0; i < model.trafficUserListAC.length; i++) {
				model.trafficUserListAC[i].yyyy = model.trafficUserListAC[i].yyyymm.getFullYear();
				model.trafficUserListAC[i].mm = model.trafficUserListAC[i].yyyymm.getMonth()+1;
			}
			this.document.trafficListDataGrid.dataProvider = this.model.trafficUserListAC;
		}

		private function TrafficListFaultHandler(event:FaultEvent):void {
            //Alert.show(Message.SERVER_ACCESS_ERROR_MESSAGE);
            Message.showErrorMessage(event);
		}
	}
}