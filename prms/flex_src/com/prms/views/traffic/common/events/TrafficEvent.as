package com.prms.views.traffic.common.events
{
	import com.prms.vo.TrafficRegular;

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

		// 定期部分の「定期券」の行を追加する時に初期値セッティッグ
		private function getRegTrainForm():Object{
			var obj:TrafficRegular = new TrafficRegular();

            obj.departurePoint = "";
            obj.arrivalPoint = "";
			obj.section = "";
//			obj.period = "";
			obj.fare = 0;
			obj.note = "";

			return obj;
		}

		// 定期部分の「その他」の行を追加する時に初期値セッティッグ
//		private function getOtherForm():Object{
//			var otherObj:TrafficKind = new TrafficKind();
//			otherObj.startPeriod = "";
//			otherObj.endPeriod = "";
//			otherObj.period = "";
//			otherObj.otherRegFare;
//			otherObj.otherRegFareRem = "";

//			return otherObj;
//		}

		// 行を追加する
		private function setAddRow(type:String):void{
			if( type == ADD_ROW ){
				this.addRowItem = getRegTrainForm();
				this.addRowItem.seq = getSeq();
			}
//			else if( type == OTHER_ADD_ROW ){
//				this.addRowItem = getOtherForm();
//				this.addRowItem.seq = getSeq();
//			}
		}

		// 削除する時
		private function setDeleteSeq(type:String):void{
            if( type == DELETE_ROW ){
                var doc:DataGrid = DataGrid(document.owner);
                deleteSeq = doc.selectedItem["seq"];
            }else if( type == OTHER_DELETE_ROW ){
            	var otherDoc:DataGrid = DataGrid(document.owner);
				deleteSeq = otherDoc.selectedItem["seq"];
            }
        }
	}
}