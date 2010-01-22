package com.prms.business.commands.traffic {
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.prms.model.TrafficModelLocator;

	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;


	public class TrafficUserListCommand implements ICommand {

		private var model:TrafficModelLocator = TrafficModelLocator.getInstance();

		public function execute(event:CairngormEvent):void {

			var responder:Responder = new Responder(TrafficListResultHandler, TrafficListFaultHandler);

		}

		private function TrafficListResultHandler(event:ResultEvent):void {

		}

		private function TrafficListFaultHandler(event:FaultEvent):void {

		}
	}
}