package com.prms.views.timesheet.admin.handlers {

	import com.prms.Constants;
	import com.prms.business.events.timesheet.GetCurrentTimeEvent;
	import com.prms.business.events.timesheet.LoadTimesheetListEvent;
	import com.prms.business.events.timesheet.LoadTimesheetDetailsEvent;
	import com.prms.model.TimesheetModelLocator;
	import com.prms.views.timesheet.admin.AdminTimesheetList;
	import com.prms.vo.Timesheet;

	import flash.events.MouseEvent;

	import mx.controls.Alert;
	import mx.controls.DataGrid;
	import mx.core.IMXMLObject;
	import mx.events.FlexEvent;
	import mx.events.ListEvent;

    public class AdminTimesheetListHandler implements IMXMLObject{

		[Bindable] public var currentDate:String;
		[Bindable] public var model:TimesheetModelLocator = TimesheetModelLocator.getInstance();
		private var document:AdminTimesheetList;
		private var vo:Timesheet;

        public function initialized(document:Object, id:String):void {
            this.document = document as AdminTimesheetList;
            this.document.addEventListener(FlexEvent.CREATION_COMPLETE, creationCompleteHandler);
        }

        private function creationCompleteHandler(event:FlexEvent):void {
        	// 会社選択ボタンイベントリスナー
			this.document.buttonRoue.addEventListener(MouseEvent.CLICK, findTimesheetListHandler);
			this.document.buttonRoueSuite.addEventListener(MouseEvent.CLICK, findTimesheetListHandler);
			this.document.buttonRoueLearning.addEventListener(MouseEvent.CLICK, findTimesheetListHandler);

			//年月選択datechooserイベントリスナー
			this.document.datechooserYYYYMM.addEventListener(MouseEvent.CLICK, findTimesheetListByDateChooserHandler);

			//勤務表ダブルクリックイベントリスナー
			this.document.datagridTimesheetList.addEventListener(ListEvent.ITEM_DOUBLE_CLICK, getTimesheetDetailHandler);

			//初期化処理
			initTimesheetList();
        }

		// 勤務表初期化処理を行う
        private function initTimesheetList():void {
			//サーバーから現在時間を取得
			var getCurrentTimeEvent:GetCurrentTimeEvent = new GetCurrentTimeEvent(this.document);
			getCurrentTimeEvent.dispatch();
        }

		/**
		 * 会社選択イベントハンドラー
		 */
        private function findTimesheetListHandler(event:MouseEvent):void {
        	event.currentTarget.enabled = false;
			document.vboxTimesheetList.visible = true;
        	this.document.textTimesheetTitle.text = "勤務表一覧";

        	// 選択されている年月を取得
        	var year:int = document.datechooserYYYYMM.displayedYear;
        	var month:int = document.datechooserYYYYMM.displayedMonth;

			vo = new Timesheet();
			vo.yyyymm = new Date(year, month);

			switch(event.currentTarget.name) {
				case "buttonRoue":
					vo.comCode = Constants.COMCODE_ROUE;
				break;
				case "buttonRoueSuite":
					vo.comCode = Constants.COMCODE_ROUE_SUITE;
				break;
				case "buttonRoueLearning":
					vo.comCode = Constants.COMCODE_ROUE_LEARNING;
				break;
				default:
					Alert.show("もう一度会社を選択してください。", "PRMS ERROR");
			}

			if (vo.comCode == "" || vo.comCode == null) {
				this.document.textTimesheetTitle.text = "もう一度会社を選択してください。";
				if (!event.currentTarget.enabled) {
					event.currentTarget.enabled = true;
				}
				return;
			}

			// 引数 eventype, vo, comCode, document(処理が終わったら会社選択ボタンを再表示)
			var loadTimesheetLiveEvent:LoadTimesheetListEvent = new LoadTimesheetListEvent(vo, this.document);
			loadTimesheetLiveEvent.dispatch();
        }

        /**
        * Datechooserで選択する年月によって勤務表を取得するイベントハンドラー
        * */
        private function findTimesheetListByDateChooserHandler(event:MouseEvent):void {
			if (vo.comCode == null || vo.comCode == "") {
	        	Alert.show("会社コードが設定されていません。", "PRMS ERROR");
			}

			var year:int = document.datechooserYYYYMM.displayedYear;
        	var month:int = document.datechooserYYYYMM.displayedMonth;
			vo.yyyymm = new Date(year, month);

			var loadTimesheetLiveEvent:LoadTimesheetListEvent = new LoadTimesheetListEvent(vo, this.document);
			loadTimesheetLiveEvent.dispatch();
        }

		/**
		 * 勤務表ダブルクリックする際、勤務表詳細画面遷移処理
		 * */
        private function getTimesheetDetailHandler(event:ListEvent):void {
			var target:DataGrid = event.currentTarget as DataGrid;
			//var paramVO:Timesheet = new Timesheet();
			//paramVO.empNo = target.selectedItem.empNo;
			//paramVO.statusCode = target.selectedItem.statusCode;
			//paramVO.comCode = vo.comCode;
			//paramVO.yyyymm = vo.yyyymm;
			vo.empNo = target.selectedItem.empNo;
			vo.statusCode = target.selectedItem.statusCode;

			var loadTimesheetDetailsEvent:LoadTimesheetDetailsEvent = new LoadTimesheetDetailsEvent(vo, null, this.document);
			 loadTimesheetDetailsEvent.dispatch();

			//TimesheetViewStackController.viewstackChange(AdminTimesheetMain(this.document.parentDocument),Constants.ADMIN_TIMESHEET_DETAILS, true);
        }

    }
}