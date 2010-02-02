package com.prms.client.flex.business.commands.traffic
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.prms.client.flex.business.delegates.TrafficDelegate;
	import com.prms.client.flex.business.events.traffic.LoadRegOtherListEvent;
	import com.prms.client.flex.model.TrafficModelLocator;
	import com.prms.client.flex.views.traffic.user.UserTrafficRegOther;
	import com.prms.client.flex.vo.TrafficRegular;

	import mx.collections.ArrayCollection;
	import mx.collections.IViewCursor;
	import mx.controls.Alert;
	import mx.formatters.DateFormatter;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;

	public class LoadRegOtherListCommand implements ICommand{
		private var model:TrafficModelLocator = TrafficModelLocator.getInstance();
		private var trafficRegular:TrafficRegular;
		private var doc:UserTrafficRegOther;

		public function execute(event:CairngormEvent):void{
			var responder:Responder = new Responder(loadRegOtherResultHandler, loadRegOtherFaultHandler);
			var delegate:TrafficDelegate = new TrafficDelegate(responder);

			trafficRegular = LoadRegOtherListEvent(event).trafficRegular;
			delegate.loadRegOtherList(trafficRegular);
		}

		private function loadRegOtherResultHandler(event:ResultEvent):void{
			var regOtherList:ArrayCollection = event.result as ArrayCollection;

			if( regOtherList != null ){
				var cursor:IViewCursor = regOtherList.createCursor();

				while(!cursor.afterLast){
					trafficRegular = cursor.current as TrafficRegular;
					model.trafficRegular = trafficRegular;

					var dateFormatter:DateFormatter = new DateFormatter();
					dateFormatter.formatString = "YYYY/MM/DD";

					model.trafficRegular.startDateTypeString = dateFormatter.format(trafficRegular.startDate);
					model.trafficRegular.endDateTypeString = dateFormatter.format(trafficRegular.endDate);

					model.regOtherAC.addItem(trafficRegular);
					cursor.moveNext();
				}
			}
		}

		private function loadRegOtherFaultHandler(event:FaultEvent):void{
			Alert.show("error" + event.message);
		}
	}
}