package com.prms.client.flex.views.traffic.common.handlers {
	import com.prms.client.flex.Constants;
	import com.prms.client.flex.business.events.traffic.TrafficCurrentDateEvent;
	import com.prms.client.flex.business.events.traffic.TrafficNewWriteEvent;
	import com.prms.client.flex.business.events.traffic.TrafficUserListEvent;
	import com.prms.client.flex.model.TrafficModelLocator;
	import com.prms.client.flex.util.ViewStackChangeController;
	import com.prms.client.flex.views.traffic.user.UserTrafficList;
	import com.prms.client.flex.vo.Traffic;

	import flash.events.MouseEvent;

	import mx.controls.DataGrid;
	import mx.controls.dataGridClasses.DataGridColumn;
	import mx.core.IMXMLObject;
	import mx.events.FlexEvent;
	import mx.events.ListEvent;

	public class UserTrafficListHandler implements IMXMLObject{

		private var document:UserTrafficList;
		private var traffic:Traffic;

		[Bindable]
		public var model:TrafficModelLocator = TrafficModelLocator.getInstance();

		public function initialized(document:Object, id:String):void {
			this.document = document as UserTrafficList;

			this.document.addEventListener(FlexEvent.CREATION_COMPLETE, trafficListHandler);
		}

		private function trafficListHandler(event:FlexEvent):void {

            this.document.trafficListDataGrid.addEventListener(ListEvent.ITEM_DOUBLE_CLICK, trafficListDoubleClickHandler);
            this.document.trafficNewWriteButton.addEventListener(MouseEvent.CLICK, trafficNewWriteButtonClickHandler);

            // 交通費一覧ロード
            var listEvent:TrafficUserListEvent = new TrafficUserListEvent(this.document);
            listEvent.dispatch();

            // 現在日付処理
            var currentEvent:TrafficCurrentDateEvent = new TrafficCurrentDateEvent(this.document);
            currentEvent.dispatch();

		}

		// DataGrid行番号処理
		public function dispRowNum(cItem:Object, i_column:DataGridColumn):String {
		    // datagridのitem数を取得する
		    var index:int = this.document.trafficListDataGrid.dataProvider.getItemIndex(cItem) + 1;
		    // indexリターンする
		    return String(index);
		}

        /**
         * 交通費一覧をダブルクリックした場合
         */
        private function trafficListDoubleClickHandler(event:ListEvent):void {

            var target:DataGrid = event.currentTarget as DataGrid;
            var status:String = target.selectedItem.statusCode;

			// 選択されたデータを格納する
			model.traffic.yyyymm = target.selectedItem.yyyymm;
			model.traffic.statusCode = status;

            // 勤務表詳細画面に移動
            ViewStackChangeController.viewstackChange(this.document.parentDocument, Constants.USER_TRAFFIC_TOTALS);

        }

		/**
		 * 新規作成
		 */
        private function trafficNewWriteButtonClickHandler(event:MouseEvent):void {

			traffic = new Traffic;

			// ユーザから入力された日付のタイプを変換する
			traffic.yyyymm = new Date(this.document.trafficListYearTextInput.text, Number(this.document.trafficListMonthTextInput.text) - 1);

			model.traffic.yyyymm = traffic.yyyymm;

            // 交通費新規作成処理
            var newWriteEvent:TrafficNewWriteEvent = new TrafficNewWriteEvent(traffic, this.document);
            newWriteEvent.dispatch();

        }
	}
}