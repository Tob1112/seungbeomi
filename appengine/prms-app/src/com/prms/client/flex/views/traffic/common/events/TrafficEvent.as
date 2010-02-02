package com.prms.client.flex.views.traffic.common.events
{
	import com.prms.client.flex.vo.TrafficRegular;

	import flash.events.Event;

	import mx.controls.DataGrid;

	public class TrafficEvent extends Event
	{
//		public static const SECTION_COMBOBOX_CLOSE:String = "sectionComboboxClose";
    	public static const ADD_ROW:String = "addRow";
		public static const DELETE_ROW:String = "deleteRow";
		public static const OTHER_ADD_ROW:String = "otherAddRow";
		public static const OTHER_DELETE_ROW:String = "otherDeleteRow";

		public var document:Object;
		public var addRowItem:Object;
        public var deleteSeq:int = 0;
        private static var seq:int = 0;
//    	public var trafficHandler:TrafficHandler;

        private static function getSeq():int{
            return seq++;
        }

        public function TrafficEvent(type:String, document:Object) {
        	super(type);
			this.document = document;
//        	trafficHandler = new TrafficHandler(type, document);
			setAddRow(type);
			setDeleteSeq(type);
        }

		/**
		 * 初期値セッティング
		 */
		private function getRegForm(type:String):Object{
			var obj:TrafficRegular = new TrafficRegular();
			switch(type){
				case ADD_ROW:
					obj.departurePoint = "";
		            obj.arrivalPoint = "";
					obj.section = "";
					obj.fare = 0;
					obj.note = "";
				break;
				case OTHER_ADD_ROW:
					obj.startDate;
					obj.endDate;
					obj.fare = 0;
					obj.note = "";
				break;
			}
			return obj;
		}

		/**
		 * 「＋」ボタンが押下された時、一行を追加する。
		 */
		private function setAddRow(type:String):void{
			switch(type){
				case ADD_ROW:
					this.addRowItem = getRegForm(ADD_ROW);
					this.addRowItem.seq = getSeq();
				break;
				case OTHER_ADD_ROW:
					this.addRowItem = getRegForm(OTHER_ADD_ROW);
					this.addRowItem.seq = getSeq();
				break;
			}
		}

		/**
		 * 削除ボタンが押下された時、一連番号をセットする。
		 */
		private function setDeleteSeq(type:String):void{
            if( type == DELETE_ROW ){
                var doc:DataGrid = DataGrid(document.owner);
                deleteSeq = doc.selectedItem["seq"];
            }
        }
	}
}