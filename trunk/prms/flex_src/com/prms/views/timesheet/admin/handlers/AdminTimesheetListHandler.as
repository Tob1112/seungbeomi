package com.prms.views.timesheet.admin.handlers {

	import com.prms.Constants;
	import com.prms.business.events.timesheet.CompareTimesheetEvent;
	import com.prms.business.events.timesheet.GetCurrentTimeEvent;
	import com.prms.business.events.timesheet.GetTimesheetSummaryEvent;
	import com.prms.business.events.timesheet.LoadTimesheetDetailsEvent;
	import com.prms.business.events.timesheet.LoadTimesheetListEvent;
	import com.prms.model.TimesheetModelLocator;
	import com.prms.views.timesheet.admin.AdminTimesheetList;
	import com.prms.vo.Timesheet;

	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	import mx.collections.ArrayCollection;
	import mx.collections.IList;
	import mx.controls.Alert;
	import mx.controls.DataGrid;
	import mx.core.IMXMLObject;
	import mx.events.DragEvent;
	import mx.events.FlexEvent;
	import mx.events.ListEvent;

    public class AdminTimesheetListHandler implements IMXMLObject{

		[Bindable] public var currentDate:String;
		[Bindable] public var model:TimesheetModelLocator = TimesheetModelLocator.getInstance();
		private var document:AdminTimesheetList;
		private var vo:Timesheet;
		public var isShowTimesheetSummary:Boolean = false;
		public var isCompare:Boolean = false;
		private var isSetBorderColor:Boolean = false;
		private var tempBorderColor:uint;
		private var tempBorderThickness:uint;
		private var timer:Timer;

        public function initialized(document:Object, id:String):void {
            this.document = document as AdminTimesheetList;
            this.document.addEventListener(FlexEvent.CREATION_COMPLETE, creationCompleteHandler);
        }

        private function creationCompleteHandler(event:FlexEvent):void {
        	this.document.currentState = "default";
        	// 会社選択ボタンイベントリスナー
			this.document.buttonRoue.addEventListener(MouseEvent.CLICK, findTimesheetListHandler);
			this.document.buttonRoueSuite.addEventListener(MouseEvent.CLICK, findTimesheetListHandler);
			this.document.buttonRoueLearning.addEventListener(MouseEvent.CLICK, findTimesheetListHandler);
			//年月選択datechooserイベントリスナー
			this.document.datechooserYYYYMM.addEventListener(MouseEvent.CLICK, findTimesheetListByDateHandler);
			//今月に戻る
			this.document.buttonThisMonth.addEventListener(MouseEvent.CLICK, findTimesheetListByDateHandler);
			//勤務表クリックイベントリスナー:勤務表サンマーリー表示
			this.document.datagridTimesheetList.addEventListener(ListEvent.ITEM_CLICK, getTimesheetSummaryHandler);
			//勤務表ダブルクリックイベントリスナー
			this.document.datagridTimesheetList.addEventListener(ListEvent.ITEM_DOUBLE_CLICK, getTimesheetDetailHandler);
			//勤務表比較
			this.document.buttonCompareAndBackToList.addEventListener(MouseEvent.CLICK, compareTimesheetHandler);

			//勤務表比較リストにドラックアンドドロップ
			this.document.datagridTimesheetList.addEventListener(DragEvent.DRAG_START, dragStartTimesheetHandler);	//ドラック開始
			this.document.datagridCompareTimesheet.addEventListener(DragEvent.DRAG_ENTER, dragEnterListCompareTimesheetHandler);
			this.document.datagridCompareTimesheet.addEventListener(DragEvent.DRAG_EXIT, dragExitListCompareTimesheetHandler);
			this.document.datagridCompareTimesheet.addEventListener(DragEvent.DRAG_DROP, dragDropListCompareTimesheetHandler);	//ドロップ
			//勤務表比較リストを初期化
			this.document.buttonResetDataGridCompareTimesheet.addEventListener(MouseEvent.CLICK, resetDatagridCompareTimesheetHandler);
			//比較勤務表リストのdataProviderとモデルとの連携
			this.document.datagridCompareTimesheet.dataProvider = this.model.compareTimesheetAC;

			//初期化処理
			initTimesheetList();
        }

		// 勤務表初期化処理を行う
        private function initTimesheetList():void {
			//サーバーから現在時間を取得
			var getCurrentTimeEvent:GetCurrentTimeEvent = new GetCurrentTimeEvent(this.document);
			getCurrentTimeEvent.dispatch();
			initVboxExtendTimesheet(true);
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
					initVboxExtendTimesheet(true);
					vo.comCode = Constants.COMCODE_ROUE;
				break;
				case "buttonRoueSuite":
					initVboxExtendTimesheet(true);
					vo.comCode = Constants.COMCODE_ROUE_SUITE;
				break;
				case "buttonRoueLearning":
					initVboxExtendTimesheet(true);
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
        private function findTimesheetListByDateHandler(event:MouseEvent):void {

			var year:int = 0;
			var month:int = 0;

			switch (event.currentTarget.name) {
				case "datechooserYYYYMM":	//datechooserから年月選択時
					year = this.document.datechooserYYYYMM.displayedYear;
		        	month = this.document.datechooserYYYYMM.displayedMonth;
				break;
				case "buttonThisMonth":	//今月ボタン押下時
					year = model.yyyymm.getFullYear();
					month = model.yyyymm.getMonth();
					// datechooserYYYYMMを今月に戻る
					this.document.datechooserYYYYMM.displayedYear = model.yyyymm.getFullYear();
					this.document.datechooserYYYYMM.displayedMonth = model.yyyymm.getMonth();
				break;
			}

			if (vo.comCode == null || vo.comCode == "") {
	        	Alert.show("会社コードが設定されていません。", "PRMS ERROR");
			}

			vo.yyyymm = new Date(year, month);

			var loadTimesheetLiveEvent:LoadTimesheetListEvent = new LoadTimesheetListEvent(vo, this.document);
			loadTimesheetLiveEvent.dispatch();
        }

		/**
		 *  勤務表サンマーリー表示
		 */
        private function getTimesheetSummaryHandler(event:ListEvent):void {

        	initVboxExtendTimesheet(false);

        	var target:DataGrid = event.currentTarget as DataGrid;
        	vo.empNo = target.selectedItem.empNo;
			vo.statusCode = target.selectedItem.statusCode;

			var getTimesheetSummaryEvent:GetTimesheetSummaryEvent = new GetTimesheetSummaryEvent(vo, this.document);
			getTimesheetSummaryEvent.dispatch();
        }

		/**
		 * 勤務表ダブルクリックする際、勤務表詳細画面遷移処理
		 **/
        private function getTimesheetDetailHandler(event:ListEvent):void {
			var target:DataGrid = event.currentTarget as DataGrid;
			vo.empNo = target.selectedItem.empNo;
			vo.statusCode = target.selectedItem.statusCode;

			var loadTimesheetDetailsEvent:LoadTimesheetDetailsEvent = new LoadTimesheetDetailsEvent(vo, null, this.document);
			 loadTimesheetDetailsEvent.dispatch();
        }

		//勤務表拡張機能の初期化
        private function initVboxExtendTimesheet(isShow:Boolean):void {
        	if (this.model.timesheetSummary.empNo == null || this.model.timesheetSummary.empNo == "") {
        		this.document.labelNotSelectedTimesheet.height = 20;
        		this.document.labelNotSelectedTimesheet.visible = true;
        		this.document.formTimesheetSummary.visible = false;
        	} else {
        		this.document.labelNotSelectedTimesheet.height = 0;
        		this.document.labelNotSelectedTimesheet.visible = false;
        		this.document.formTimesheetSummary.visible = true;
        	}

        	if (isShow) {
        		this.document.currentState = "default";
	        	this.document.labelNotSelectedTimesheet.height = 20;
        	} else {
        		this.document.currentState = "expandVboxExtendTimesheet";
        		this.document.labelNotSelectedTimesheet.height = 0;
        	}
        }

		//勤務表比較
        private function compareTimesheetHandler(event:MouseEvent):void {

        	if (this.model.compareTimesheetAC.length == 0) {
        		timer = new Timer(2000);
        		timer.addEventListener(TimerEvent.TIMER,  showMessageHandler);
        		timer.start();
        		this.document.hboxCompareControl.height = 0;
        		this.document.hboxCompareControl.visible = false;
        		this.document.compareTimesheetMessageLabel.text = "勤務表を選択してください。";
        		this.document.compareTimesheetMessageLabel.visible = true;

        		return;
        	}

    		this.document.buttonCompareAndBackToList.enabled = false;
    		this.document.buttonResetDataGridCompareTimesheet.enabled = false;

        	if (!isCompare) {	//compare
        		var compareTimesheetEvent:CompareTimesheetEvent = new CompareTimesheetEvent(this.document);
        		compareTimesheetEvent.dispatch();
//	        	this.document.datagridTimesheetList.visible = false;
//	        	this.document.datagridTimesheetList.width = 0;
//	        	this.document.datagridTimesheetList.height = 0;
//				this.document.hboxCompareTimesheet.visible = true;
//				this.document.hboxCompareTimesheet.percentWidth = 100;
//				this.document.hboxCompareTimesheet.percentHeight = 100;
				isCompare = true;
        	} else {	// back to list
        		compareTimesheetBackToList();
        	}
        }

        private function compareTimesheetBackToList():void {
        	this.document.datagridTimesheetList.visible = true;
        	this.document.datagridTimesheetList.percentWidth = 100;
        	this.document.datagridTimesheetList.percentHeight = 100;
			this.document.compareTimesheetHDividedBox.visible = false;
			this.document.compareTimesheetHDividedBox.width = 0;
			this.document.compareTimesheetHDividedBox.height = 0;
			//this.model.compareTimesheetAC.removeAll();
			this.model.compareTimesheetAC.refresh();
			this.document.buttonCompareAndBackToList.label = "compare";
			this.document.buttonCompareAndBackToList.enabled = true;
    		this.document.buttonResetDataGridCompareTimesheet.enabled = true;
			isCompare = false;
        }

		//ドラック開始
        private function dragStartTimesheetHandler(event:DragEvent):void {
        	if (this.document.currentState == "default") {
        		initVboxExtendTimesheet(false);
        	}
        }

		//勤務表比較リストにドラックが入る際
        private function dragEnterListCompareTimesheetHandler(event:DragEvent):void {
			if (!isSetBorderColor) {
				tempBorderColor = event.currentTarget.getStyle("borderColor");
				tempBorderThickness = event.currentTarget.getStyle("borderThickness");
				isSetBorderColor = true;
			}
			event.currentTarget.setStyle("borderColor","red");
			event.currentTarget.setStyle("borderThickness",2);
        }

		//勤務表比較リストにドラックが出る際
        private function dragExitListCompareTimesheetHandler(event:DragEvent):void {
			event.currentTarget.setStyle("borderColor", tempBorderColor);
			event.currentTarget.setStyle("borderThickness", tempBorderThickness);
			isSetBorderColor = false;
        }

		//勤務表比較リストにドラックアンドドロップする際
        private function dragDropListCompareTimesheetHandler(event:DragEvent):void {
			event.preventDefault();
			if (event.dragSource.hasFormat("items")) {
				var dropTarget:DataGrid = DataGrid(event.currentTarget);

				var itemsArray:Array = event.dragSource.dataForFormat("items") as Array;
				var tempAC:ArrayCollection = this.model.compareTimesheetAC as ArrayCollection;

				if (tempAC.length >= 0 && tempAC.length < 2) {
					// 比較対処の値を設定
					itemsArray[0].comCode = vo.comCode;
					//itemsArray[0].empNo = event.currentTarget.empNo;
					var year:Number = this.document.datechooserYYYYMM.displayedYear;
		        	var month:Number = this.document.datechooserYYYYMM.displayedMonth;
					itemsArray[0].yyyymm = new Date(year, month);
					IList(dropTarget.dataProvider).addItem(itemsArray[0]);
				} else {
					trace("is over!!");
				}
			}
			dragExitListCompareTimesheetHandler(event);
        }

		//勤務表比較リストを初期化
        private function resetDatagridCompareTimesheetHandler(event:MouseEvent):void {
			this.model.compareTimesheetAC.removeAll();
			this.model.compareTimesheetAC.refresh();
        	this.document.datagridCompareTimesheet.dataProvider = this.model.compareTimesheetAC;
			compareTimesheetBackToList();
        }

		private function showMessageHandler(event:TimerEvent):void {
			timer.stop();
			this.document.hboxCompareControl.height = 30;
    		this.document.compareTimesheetMessageLabel.visible = false;
			this.document.hboxCompareControl.visible = true;
		}
    }
}