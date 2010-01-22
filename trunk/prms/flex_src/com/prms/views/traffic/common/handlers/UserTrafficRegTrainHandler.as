package com.prms.views.traffic.common.handlers
{
	import com.prms.business.events.traffic.LoadRegTotalsEvent;
	import com.prms.business.events.traffic.LoadRegTrainListEvent;
	import com.prms.model.TrafficModelLocator;
	import com.prms.views.traffic.common.events.TrafficEvent;
	import com.prms.views.traffic.user.UserTrafficRegTrain;
	import com.prms.vo.TrafficRegular;

	import mx.controls.Alert;
	import mx.core.IMXMLObject;
	import mx.events.DataGridEvent;
	import mx.events.FlexEvent;

	public class UserTrafficRegTrainHandler implements IMXMLObject{

		[Bindable]
		public var regTrainTotal:int;
		[Bindable]
		public var model:TrafficModelLocator = TrafficModelLocator.getInstance();
		private var document:UserTrafficRegTrain;

		public function initialized(document:Object, id:String):void{
			this.document = document as UserTrafficRegTrain;
			this.document.addEventListener(FlexEvent.CREATION_COMPLETE, regTrainComplete);
		}

		private function regTrainComplete(event:FlexEvent):void{
			this.document.addEventListener(TrafficEvent.ADD_ROW, addRow);
			this.document.regTrainDG.addEventListener(TrafficEvent.DELETE_ROW, deleteRowHandler);
			this.document.addEventListener(DataGridEvent.ITEM_EDIT_END, editRegTrainFareCell);

			var date:Date = new Date();
			var trafficRegular:TrafficRegular = new TrafficRegular();
			trafficRegular.yyyymm = new Date(date.fullYear, 1-1, 01);
//			model.trafficRegular.yyyymm = new Date(date.fullYear, 1-1, 01);
			// 定期券一覧ロード
			var loadRegTrainList:LoadRegTrainListEvent = new LoadRegTrainListEvent(trafficRegular);
			loadRegTrainList.dispatch();

			// 合計ロード
			var loadRegTotals:LoadRegTotalsEvent = new LoadRegTotalsEvent();
			loadRegTotals.dispatch();
		}

		// 行追加のイベント処理
		private function addRow(event:TrafficEvent):void{
			if ( model.regTrainAC.source.length < 4 ){
				model.regTrainAC.addItem(event.addRowItem);
			}else if ( model.regTrainAC.source.length >= 4 ){
				Alert.show("データの追加は４件までになります。");
			}
		}

		// 削除イベント処理
		private function deleteRowHandler(event:TrafficEvent):void{
			for ( var i:int=0; i < model.regTrainAC.source.length; i++ ){
				var regular:TrafficRegular = TrafficRegular(model.regTrainAC.getItemAt(i))

				if ( regular.seq == event.deleteSeq ){

					regTrainTotal -= model.regTrainAC.getItemAt(i)["fare"];
					this.document.regTrainTotalLabel.text = regTrainTotal.toString();
					model.regTrainAC.removeItemAt(i);
					model.regTrainAC.refresh();
				}
			}
		}


//		private function regTrainfareLblFunc(item:Object, column:DataGridColumn):String{
//			return cfregTrainfare.format(item.regTrainFare);
//		}

		private function editRegTrainFareCell(event:DataGridEvent):void{
			if( event.columnIndex == 3 ){
				calculateTotal();
			}else if( event.columnIndex == 2 ){

			}
		}
		private function calculateTotal():void{
			regTrainTotal = 0;

			for(var i:int=0; i<model.regTrainAC.source.length; i++){
				regTrainTotal += int(model.regTrainAC.getItemAt(i)["fare"]);
				this.document.regTrainTotalLabel.text = regTrainTotal.toString();
			}
		}
	}
}