package com.prms.views.traffic.common.handlers {
	import com.prms.Constants;
	import com.prms.business.events.traffic.TrafficUserListEvent;
	import com.prms.util.ViewStackChangeController;
	import com.prms.views.traffic.user.UserTrafficList;

	import mx.controls.dataGridClasses.DataGridColumn;
	import mx.core.IMXMLObject;
	import mx.events.FlexEvent;
	import mx.events.ListEvent;

	public class UserTrafficListHandler implements IMXMLObject{

		private var document:UserTrafficList;

		public function initialized(document:Object, id:String):void {
			this.document = document as UserTrafficList;

			this.document.addEventListener(FlexEvent.CREATION_COMPLETE, trafficListHandler);
		}

		private function trafficListHandler(event:FlexEvent):void {

            this.document.trafficListDataGrid.addEventListener(ListEvent.ITEM_DOUBLE_CLICK, trafficListDoubleClickHandler);

            // 交通費一覧ロード
            var listEvent:TrafficUserListEvent = new TrafficUserListEvent(this.document);
            listEvent.dispatch();
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
         *
         */
        private function trafficListDoubleClickHandler(event:ListEvent):void {

            // 勤務表詳細画面に移動
            ViewStackChangeController.viewstackChange(this.document.parentDocument, Constants.USER_TRAFFIC_TOTALS);

        }
	}
}