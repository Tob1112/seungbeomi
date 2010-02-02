package com.prms.client.flex.views.traffic.common.handlers
{
	import com.prms.client.flex.business.events.traffic.LoadRegOtherListEvent;
	import com.prms.client.flex.business.events.traffic.LoadRegTotalsEvent;
	import com.prms.client.flex.model.TrafficModelLocator;
	import com.prms.client.flex.views.traffic.common.events.TrafficEvent;
	import com.prms.client.flex.views.traffic.user.UserTrafficRegOther;
	import com.prms.client.flex.vo.Traffic;
	import com.prms.client.flex.vo.TrafficRegular;

	import mx.controls.Alert;
	import mx.core.IMXMLObject;
	import mx.events.DataGridEvent;
	import mx.events.FlexEvent;

	public class UserTrafficRegOtherHandler implements IMXMLObject{
		[Bindable]
		public var model:TrafficModelLocator = TrafficModelLocator.getInstance();
		private var document:UserTrafficRegOther;
		private var regOtherTotal:int = 0;

		public function initialized(document:Object, id:String):void{
			this.document = document as UserTrafficRegOther;
			this.document.addEventListener(FlexEvent.CREATION_COMPLETE, regOtherComplete);
		}

		private function regOtherComplete(event:FlexEvent):void{
			this.document.addEventListener(TrafficEvent.OTHER_ADD_ROW, addRow);
			this.document.regOtherDG.addEventListener(TrafficEvent.DELETE_ROW, deleteRowHandler);
			this.document.addEventListener(DataGridEvent.ITEM_EDIT_END, editRegOtherFareCell);


			var date:Date = new Date();
			var traffic:Traffic = new Traffic();
			var trafficRegular:TrafficRegular = new TrafficRegular();

			traffic.yyyymm = new Date(date.fullYear, 1-1, 01);
			trafficRegular.yyyymm = traffic.yyyymm;

			var loadRegOtherList:LoadRegOtherListEvent = new LoadRegOtherListEvent(trafficRegular);
			loadRegOtherList.dispatch();

			// 合計ロード
			var loadRegTotals:LoadRegTotalsEvent = new LoadRegTotalsEvent(traffic);
			loadRegTotals.dispatch();
		}

		// 行追加のイベント処理
		private function addRow(event:TrafficEvent):void{
			if ( model.regOtherAC.source.length < 4 ){
				model.regOtherAC.addItem(event.addRowItem);
			}else if ( model.regOtherAC.source.length >= 4 ){
				Alert.show("データの追加は４件までになります。");
			}
		}

		// 削除イベント処理
		private function deleteRowHandler(event:TrafficEvent):void{
			for ( var i:int=0; i < model.regOtherAC.source.length; i++ ){
				var regular:TrafficRegular = TrafficRegular(model.regOtherAC.getItemAt(i))

				if ( regular.seq == event.deleteSeq ){

					regOtherTotal -= model.regOtherAC.getItemAt(i)["fare"];
					this.document.regOtherTotalLabel.text = regOtherTotal.toString();

					model.regOtherAC.removeItemAt(i);
					model.regOtherAC.refresh();
				}
			}
		}

		private function editRegOtherFareCell(event:DataGridEvent):void{
			if( event.columnIndex == 3 ){
				calculateTotal();
			}else if( event.columnIndex == 2 ){

			}
		}
		private function calculateTotal():void{
			regOtherTotal = 0;

			for(var i:int=0; i<model.regOtherAC.source.length; i++){
				regOtherTotal += int(model.regOtherAC.getItemAt(i)["fare"]);
				this.document.regOtherTotalLabel.text = regOtherTotal.toString();
			}
		}
	}
}