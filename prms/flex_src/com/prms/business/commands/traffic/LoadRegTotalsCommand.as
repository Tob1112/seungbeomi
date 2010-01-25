package com.prms.business.commands.traffic
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.prms.business.delegates.TrafficDelegate;
	import com.prms.model.TrafficModelLocator;
	import com.prms.views.traffic.user.UserTrafficRegTrain;
	import com.prms.vo.Traffic;

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

			delegate.loadRegTotals(traffic);
		}

		private function loadRegTotalsResultHandler(event:ResultEvent):void{
			var result:Traffic = event.result as Traffic;

			if( result != null ){
				model.traffic = result;
			}
		}

		private function loadRegTotalsFaultHandler(event:FaultEvent):void{
			Alert.show("error" + event.message);
		}

	}
}