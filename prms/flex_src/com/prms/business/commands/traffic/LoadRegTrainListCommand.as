package com.prms.business.commands.traffic
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.prms.business.delegates.TrafficDelegate;
	import com.prms.business.events.traffic.LoadRegTrainListEvent;
	import com.prms.model.TrafficModelLocator;
	import com.prms.views.traffic.user.UserTrafficRegTrain;
	import com.prms.vo.TrafficRegular;

	import mx.collections.ArrayCollection;
	import mx.collections.IViewCursor;
	import mx.controls.Alert;
	import mx.formatters.DateFormatter;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;

	public class LoadRegTrainListCommand implements ICommand{
		private var model:TrafficModelLocator = TrafficModelLocator.getInstance();
		private var trafficRegular:TrafficRegular;
		private var doc:UserTrafficRegTrain;

		public function execute(event:CairngormEvent):void{
			var responder:Responder = new Responder(loadRegTrainListResultHandler, loadRegTrainListFaultHandler);
			var delegate:TrafficDelegate = new TrafficDelegate(responder);

			trafficRegular = LoadRegTrainListEvent(event).trafficRegular;
			delegate.loadRegTrainList(trafficRegular);
		}

		private function loadRegTrainListResultHandler(event:ResultEvent):void{
			var regTrainList:ArrayCollection = event.result as ArrayCollection;

			if( regTrainList != null ){
				var cursor:IViewCursor = regTrainList.createCursor();

				while(!cursor.afterLast){
					trafficRegular = cursor.current as TrafficRegular;
					model.trafficRegular = trafficRegular;

					var dateFormatter:DateFormatter = new DateFormatter();
					dateFormatter.formatString = "YYYY/MM/DD";

					model.trafficRegular.startDateTypeString = dateFormatter.format(trafficRegular.startDate);
					model.trafficRegular.endDateTypeString = dateFormatter.format(trafficRegular.endDate);

					model.regTrainAC.addItem(trafficRegular);
					cursor.moveNext();
				}
			}
		}

		private function loadRegTrainListFaultHandler(event:FaultEvent):void{
			Alert.show("error" + event.message);
		}
	}
}