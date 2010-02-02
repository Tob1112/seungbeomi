package com.prms.client.flex.business.commands.traffic
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.prms.client.flex.business.delegates.TrafficDelegate;
	import com.prms.client.flex.business.events.traffic.LoadRegTotalsEvent;
	import com.prms.client.flex.model.TrafficModelLocator;
	import com.prms.client.flex.views.traffic.user.UserTrafficRegTrain;
	import com.prms.client.flex.vo.Traffic;

	import mx.controls.Alert;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;

	public class LoadRegTotalsCommand implements ICommand{
		private var model:TrafficModelLocator = TrafficModelLocator.getInstance();
		private var traffic:Traffic = new Traffic();
		private var doc:UserTrafficRegTrain;

		public function execute(event:CairngormEvent):void{
			var responder:Responder = new Responder(loadRegTotalsResultHandler, loadRegTotalsFaultHandler);
			var delegate:TrafficDelegate = new TrafficDelegate(responder);

			traffic = LoadRegTotalsEvent(event).traffic;
			delegate.loadRegTotals(traffic);
		}

		private function loadRegTotalsResultHandler(event:ResultEvent):void{
			var result:Traffic = event.result as Traffic;

			if( result != null ){
				model.traffic.trainTotal = result.trainTotal;
				model.traffic.otherTotal = result.otherTotal;
			}
		}

		private function loadRegTotalsFaultHandler(event:FaultEvent):void{
			Alert.show("error" + event.message);
		}

	}
}