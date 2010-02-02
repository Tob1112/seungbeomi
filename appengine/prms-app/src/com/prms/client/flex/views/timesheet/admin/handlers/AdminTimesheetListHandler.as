package com.prms.client.flex.views.timesheet.admin.handlers {

	import com.prms.client.flex.Constants;
	import com.prms.client.flex.business.events.timesheet.CompareTimesheetEvent;
	import com.prms.client.flex.business.events.timesheet.GetCurrentTimeEvent;
	import com.prms.client.flex.business.events.timesheet.GetTimesheetSummaryEvent;
	import com.prms.client.flex.business.events.timesheet.LoadTimesheetDetailsEvent;
	import com.prms.client.flex.business.events.timesheet.LoadTimesheetListEvent;
	import com.prms.client.flex.model.TimesheetModelLocator;
	import com.prms.client.flex.views.timesheet.admin.AdminTimesheetList;
	import com.prms.client.flex.views.timesheet.admin.CompareTimesheetWindow;
	import com.prms.client.flex.vo.Timesheet;

	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	import mx.collections.ArrayCollection;
	import mx.collections.IList;
	import mx.collections.IViewCursor;
	import mx.controls.Alert;
	import mx.controls.DataGrid;
	import mx.core.IMXMLObject;
	import mx.events.DragEvent;
	import mx.events.FlexEvent;
	import mx.events.ListEvent;
	import mx.managers.PopUpManager;

    public class AdminTimesheetListHandler implements IMXMLObject{

		[Bindable] public var currentDate:String;
		[Bindable] public var model:TimesheetModelLocator = TimesheetModelLocator.getInstance();
		private var doc:AdminTimesheetList;
		private var vo:Timesheet;
		public var isShowTimesheetSummary:Boolean = false;
		public var isCompare:Boolean = false;
		private var isSetBackgroundColor:Boolean = false;
		private var tempBackgroundColor:uint;
		private var timer:Timer;
		private const INITIALIZE_TIMESHEET_EXTENSION_TRUE:Boolean = true;
		private const INITIALIZE_TIMESHEET_EXTENSION_FALSE:Boolean = false;

        public function initialized(document:Object, id:String):void {
            doc = document as AdminTimesheetList;
            doc.addEventListener(FlexEvent.CREATION_COMPLETE, creationCompleteHandler);
        }

		/**
		 * イベントリスナー登録
		 */
        private function creationCompleteHandler(event:FlexEvent):void {
        	doc.currentState = "default";
			doc.buttonRoue.addEventListener(MouseEvent.CLICK, findTimesheetListHandler);										// 会社選択ボタン(roue)
			doc.buttonRoueSuite.addEventListener(MouseEvent.CLICK, findTimesheetListHandler);									// 会社選択ボタン(suite)
			doc.buttonRoueLearning.addEventListener(MouseEvent.CLICK, findTimesheetListHandler);								// 会社選択ボタン(learning)
			doc.datechooserYYYYMM.addEventListener(MouseEvent.CLICK, findTimesheetListByDateHandler);							// datechooserから年月選択
			doc.buttonThisMonth.addEventListener(MouseEvent.CLICK, findTimesheetListByDateHandler);								// 今月に戻る
			doc.datagridTimesheetList.addEventListener(ListEvent.ITEM_CLICK, getTimesheetSummaryHandler);						// 勤務表クリックイベントリスナー:勤務表サンマーリー表示
			doc.datagridTimesheetList.addEventListener(ListEvent.ITEM_DOUBLE_CLICK, getTimesheetDetailHandler);					// 勤務表ダブルクリック
			doc.buttonCompareTimesheet.addEventListener(MouseEvent.CLICK, compareTimesheetHandler);								// 勤務表比較
			doc.datagridTimesheetList.addEventListener(DragEvent.DRAG_START, dragStartTimesheetHandler);						// 勤務表リストからドラック開始
			doc.datagridCompareTimesheet.addEventListener(DragEvent.DRAG_ENTER, dragEnterListCompareTimesheetHandler);			// 勤務表比較リストにitemが入る
			doc.datagridCompareTimesheet.addEventListener(DragEvent.DRAG_EXIT, dragExitListCompareTimesheetHandler);			// 勤務表比較リストにitemが出る
			doc.datagridCompareTimesheet.addEventListener(DragEvent.DRAG_DROP, dragDropListCompareTimesheetHandler);			// 勤務表比較リストにitemをドロップ
			doc.buttonResetDataGridCompareTimesheet.addEventListener(MouseEvent.CLICK, resetDatagridCompareTimesheetHandler);	// 勤務表比較リストを初期化
			doc.datagridCompareTimesheet.dataProvider = this.model.compareTimesheetAC;											// 比較勤務表リストのdataProviderとモデルとの連携

			initTimesheetList();	//初期化処理
        }

		/**
		 * 勤務表初期化処理
		 */
        private function initTimesheetList():void {
			//サーバーから現在時間を取得
			var getCurrentTimeEvent:GetCurrentTimeEvent = new GetCurrentTimeEvent(doc);
			getCurrentTimeEvent.dispatch();
			initVBoxTimesheetExtension(INITIALIZE_TIMESHEET_EXTENSION_TRUE);

			doc.compareTimesheetMessageLabel.height = 0;
        }

		/**
		 * 会社選択イベントハンドラー
		 */
        private function findTimesheetListHandler(event:MouseEvent):void {
        	event.currentTarget.enabled = false;	// 選択されたボタンを非活性化
			doc.vboxTimesheetList.visible = true;
        	doc.textTimesheetTitle.text = "勤務表一覧";

        	// 選択されている年月を取得
        	var year:int = doc.datechooserYYYYMM.displayedYear;
        	var month:int = doc.datechooserYYYYMM.displayedMonth;

			vo = new Timesheet();
			vo.yyyymm = new Date(year, month);

			// 会社コードの設定
			switch(event.currentTarget.name) {
				case "buttonRoue":
					vo.comCode = Constants.COMCODE_ROUE;
					initVBoxTimesheetExtension(INITIALIZE_TIMESHEET_EXTENSION_TRUE);
				break;
				case "buttonRoueSuite":
					vo.comCode = Constants.COMCODE_ROUE_SUITE;
					initVBoxTimesheetExtension(INITIALIZE_TIMESHEET_EXTENSION_TRUE);
				break;
				case "buttonRoueLearning":
					vo.comCode = Constants.COMCODE_ROUE_LEARNING;
					initVBoxTimesheetExtension(INITIALIZE_TIMESHEET_EXTENSION_TRUE);
				break;
				default:
					Alert.show("もう一度会社を選択してください。", "PRMS ERROR");
			}

			//会社コードが存在しない
			if (vo.comCode == null) {
				doc.textTimesheetTitle.text = "もう一度会社を選択してください。";
				if (!event.currentTarget.enabled) {
					event.currentTarget.enabled = true;
				}
				return;
			}

			// 引数 eventype, vo, comCode, document(処理が終わったら会社選択ボタンを再表示)
			var loadTimesheetLiveEvent:LoadTimesheetListEvent = new LoadTimesheetListEvent(vo, doc);
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
					year = doc.datechooserYYYYMM.displayedYear;
		        	month = doc.datechooserYYYYMM.displayedMonth;
				break;
				case "buttonThisMonth":	//今月ボタン押下時
					year = model.yyyymm.getFullYear();
					month = model.yyyymm.getMonth();
					// datechooserYYYYMMを今月に戻る
					doc.datechooserYYYYMM.displayedYear = model.yyyymm.getFullYear();
					doc.datechooserYYYYMM.displayedMonth = model.yyyymm.getMonth();
				break;
			}

			if (vo.comCode == null) {
	        	Alert.show("会社コードが設定されていません。", "PRMS ERROR");
			}

			vo.yyyymm = new Date(year, month);

			var loadTimesheetLiveEvent:LoadTimesheetListEvent = new LoadTimesheetListEvent(vo, doc);
			loadTimesheetLiveEvent.dispatch();
        }

		/**
		 *  勤務表サンマーリー表示
		 */
        private function getTimesheetSummaryHandler(event:ListEvent):void {

        	initVBoxTimesheetExtension(INITIALIZE_TIMESHEET_EXTENSION_FALSE);

        	var target:DataGrid = event.currentTarget as DataGrid;
        	vo.empNo = target.selectedItem.empNo;
			vo.statusCode = target.selectedItem.statusCode;

			var getTimesheetSummaryEvent:GetTimesheetSummaryEvent = new GetTimesheetSummaryEvent(vo, doc);
			getTimesheetSummaryEvent.dispatch();
        }

		/**
		 * 勤務表ダブルクリックする際、勤務表詳細画面遷移処理
		 **/
        private function getTimesheetDetailHandler(event:ListEvent):void {
			var target:DataGrid = event.currentTarget as DataGrid;
			vo.empNo = target.selectedItem.empNo;
			vo.statusCode = target.selectedItem.statusCode;

			var loadTimesheetDetailsEvent:LoadTimesheetDetailsEvent = new LoadTimesheetDetailsEvent(vo, null, doc);
			 loadTimesheetDetailsEvent.dispatch();
        }

		/**
		 * 勤務表拡張機能の初期化
		 */
        private function initVBoxTimesheetExtension(isShow:Boolean):void {
        	if (!isShow) {	//拡張する
        		trace(" - expandVboxExtendTimesheet");
        		doc.currentState = "expandVboxExtendTimesheet";
    			isTimesheetSummary();
    			isShow = true;
        	} else {	//拡張しない
        		trace(" - default");
        		doc.currentState = "default";
	        	isTimesheetSummary();
	        	isShow = false;
        	}
        }

		/**
		 * 勤務表さんマーリー存在有無による画面処理
		 */
        public function isTimesheetSummary():void {
        	var empNo:String = this.model.timesheetSummary.empNo;
        	trace("<<< empNo : " + empNo);
        	if (empNo != null) {	//存在する
	        	doc.labelTimesheetSummaryTitle.text = model.timesheetSummary.displayYYYYMM + " / " + empNo + " / " + model.timesheetSummary.name;
        		doc.formTimesheetSummary.visible = true;
        	} else {	//存在しない
        		doc.formTimesheetSummary.visible = false;
        		doc.labelTimesheetSummaryTitle.text = "リストから勤務表を選択してください。";
        	}
        }

		/**
		 * 勤務表比較
		 */
        private function compareTimesheetHandler(event:MouseEvent):void {
			// 二重実行防止
    		doc.buttonCompareTimesheet.enabled = false;
    		doc.buttonResetDataGridCompareTimesheet.enabled = false;

    		trace("<<< compareTimesheetAC.length : " + this.model.compareTimesheetAC.length);

			//比較する勤務表がない場合 - メッセージ表示
        	if (this.model.compareTimesheetAC.length < 2) {
        		timer = new Timer(3000);
        		timer.addEventListener(TimerEvent.TIMER,  showMessageHandler);
        		timer.start();
        		doc.hboxCompareControl.height = 0;
        		doc.hboxCompareControl.visible = false;
        		doc.compareTimesheetMessageLabel.text = "勤務表を２個以上選択してください。";
        		doc.compareTimesheetMessageLabel.setStyle("color","red");
        		doc.compareTimesheetMessageLabel.height = 20;
        		doc.compareTimesheetMessageLabel.visible = true;
        		return;
        	}


        	if (!isCompare) {	//比較

        		var compareTimesheetEvent:CompareTimesheetEvent = new CompareTimesheetEvent(doc);
        		compareTimesheetEvent.dispatch();

				var compareTimesheetWindow:CompareTimesheetWindow = PopUpManager.createPopUp(doc, CompareTimesheetWindow, true) as CompareTimesheetWindow;
				PopUpManager.centerPopUp(compareTimesheetWindow);

				afterCompareTimesheet();
				isCompare = true;
        	} else {
        		afterCompareTimesheet();
        		isCompare = false;
        	}
        }

        public function afterCompareTimesheet():void {
			this.model.compareTimesheetAC.refresh();
			doc.buttonCompareTimesheet.enabled = true;
    		doc.buttonResetDataGridCompareTimesheet.enabled = true;
        }

		//ドラック開始
        private function dragStartTimesheetHandler(event:DragEvent):void {
        	if (doc.currentState == "default") {
        		initVBoxTimesheetExtension(INITIALIZE_TIMESHEET_EXTENSION_FALSE);
        	}
        }

		//勤務表比較リストにドラックが入る際
        private function dragEnterListCompareTimesheetHandler(event:DragEvent):void {
			if (!isSetBackgroundColor) {
				tempBackgroundColor = event.currentTarget.getStyle("backgroundColor");
				isSetBackgroundColor = true;
			}
			event.currentTarget.setStyle("backgroundColor","red");
        }

		//勤務表比較リストにドラックが出る際
        private function dragExitListCompareTimesheetHandler(event:DragEvent):void {
			event.currentTarget.setStyle("backgroundColor", tempBackgroundColor);
			isSetBackgroundColor = false;
        }

		//勤務表比較リストにドラックアンドドロップする際
        private function dragDropListCompareTimesheetHandler(event:DragEvent):void {
			event.preventDefault();
			if (event.dragSource.hasFormat("items")) {
				var dropTarget:DataGrid = DataGrid(event.currentTarget);

				var itemsArray:Array = event.dragSource.dataForFormat("items") as Array;
				var tempAC:ArrayCollection = this.model.compareTimesheetAC as ArrayCollection;

				// 比較対処の値を設定
				itemsArray[0].comCode = vo.comCode;
				var year:Number = doc.datechooserYYYYMM.displayedYear;
	        	var month:Number = doc.datechooserYYYYMM.displayedMonth;
				itemsArray[0].yyyymm = new Date(year, month);

				//compareTimesheetACに存在する勤務表なのかを検証
				if (isExistTimesheet(itemsArray[0])) {	//存在する
					Alert.show(
					"すでに存在する勤務表です。\n\n" +
					"社員番号 : " + itemsArray[0].empNo + "\n" +
					"名前 : " + itemsArray[0].name + "\n" +
					"年月 : " + itemsArray[0].yyyymm
					, "PRMS ERROR");
				} else {
					IList(dropTarget.dataProvider).addItem(itemsArray[0]);
				}
			}
			dragExitListCompareTimesheetHandler(event);
        }

		//勤務表比較リストを初期化
        private function resetDatagridCompareTimesheetHandler(event:MouseEvent):void {
			this.model.compareTimesheetAC.removeAll();
			this.model.compareTimesheetAC.refresh();
        	doc.datagridCompareTimesheet.dataProvider = this.model.compareTimesheetAC;
			afterCompareTimesheet();
        }

		private function showMessageHandler(event:TimerEvent):void {
			timer.stop();
			doc.hboxCompareControl.height = 20;
    		doc.compareTimesheetMessageLabel.visible = false;
    		doc.compareTimesheetMessageLabel.height = 0;
			doc.hboxCompareControl.visible = true;
			doc.buttonCompareTimesheet.enabled = true;
    		doc.buttonResetDataGridCompareTimesheet.enabled = true;
		}

		/**
		 * 追加されたitemがcompareTimesheetAC内部で存在するか確認
		 */
		private function isExistTimesheet(vo:Timesheet):Boolean {
			var ac:ArrayCollection = model.compareTimesheetAC;
			var cursor:IViewCursor = ac.createCursor();
			var temp:Timesheet = new Timesheet();
			while(!cursor.afterLast) {
				temp = Timesheet(cursor.current);
				trace(ac.length + " -> " + vo.empNo + " == " + temp.empNo + " && " + vo.comCode + " == " + temp.comCode + " && " + vo.yyyymm + " == " + temp.yyyymm);
				if (vo.empNo == temp.empNo && vo.comCode == temp.comCode && vo.yyyymm == temp.yyyymm) {
					trace("true");
					return true;
				}

				cursor.moveNext();
			}
			trace("false");
			return false;
		}
    }
}