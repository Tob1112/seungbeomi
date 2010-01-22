package com.prms.views.timesheet.admin.handlers {

    import com.prms.model.TimesheetModelLocator;
    import com.prms.views.timesheet.admin.AdminTimesheetDetails;

    import flash.events.Event;
    import flash.events.MouseEvent;

    import mx.core.IMXMLObject;
    import mx.events.FlexEvent;

    public class AdminTimesheetDetailsHandler implements IMXMLObject {

		[Bindable] public var model:TimesheetModelLocator = TimesheetModelLocator.getInstance();
        private var _document:AdminTimesheetDetails;

        // トグル用フラグ
        private var _isSummaryHBox:Boolean = true;
        private var _isfixTimeAdvancedDataGrid:Boolean = true;
        private var _isTimesheetDataGrid:Boolean = true;
        // 勤務表詳細表示フラグ
        private var _isDetailCheckBox:Boolean = false;

        public function initialized(document:Object, id:String):void {
            _document = AdminTimesheetDetails(document);
            _document.addEventListener(FlexEvent.CREATION_COMPLETE, creationCompleteHandler);
        }

        private function creationCompleteHandler(event:Event):void {
        	// 画面トグル用イベントリスナー
            _document.summaryLabel.addEventListener(MouseEvent.CLICK, toggleSummaryHandler);
            _document.patternLabel.addEventListener(MouseEvent.CLICK, togglePatternHandler);
            _document.timesheetLabel.addEventListener(MouseEvent.CLICK, toggleTimesheetHandler);
            //勤務表詳細表示用CheckBoxイベントハンドラー
            _document.detailCheckBox.addEventListener(Event.CHANGE, detailCheckBoxChangeHander);
            // 初期化時勤務表詳細非表示
            showTimesheetDetail(false);
        }

		/**
		 * まとめトグルハンドラー
		 */
        private function toggleSummaryHandler(event:MouseEvent):void {
            if (_isSummaryHBox) {
            	_document.summaryHBox.visible = false;
            	_document.summaryHBox.height = 0;
            	_isSummaryHBox = false;
            } else {
            	_document.summaryHBox.visible = true;
            	_document.summaryHBox.height = 95;
            	_isSummaryHBox = true;
            }
        }

		/**
		 * 勤務パターンドグルハンドラー
		 */
        private function togglePatternHandler(event:MouseEvent):void {
            if (_isfixTimeAdvancedDataGrid) {
            	_document.fixTimeAdvancedDataGrid.visible = false;
            	_document.fixTimeAdvancedDataGrid.height = 0;
            	_isfixTimeAdvancedDataGrid = false;
            } else {
            	_document.fixTimeAdvancedDataGrid.visible = true;
            	_document.fixTimeAdvancedDataGrid.height = 100;
            	_isfixTimeAdvancedDataGrid = true;
            }
        }

		/**
		 * 勤務表トグルハンドラー
		 */
        private function toggleTimesheetHandler(event:MouseEvent):void {
           /*
            if (_isTimesheetDataGrid) {
            	_document.timesheetDataGrid.visible = false;
            	_document.detailCheckBox.visible = false;
            	_document.timesheetDataGrid.height = 0;
            	_isTimesheetDataGrid = false;
            } else {
            	_document.timesheetDataGrid.visible = true;
            	_document.detailCheckBox.visible = true;
            	_document.timesheetDataGrid.percentHeight = 100;
            	_isTimesheetDataGrid = true;
            }
            */
        }

        /**
         *　勤務表詳細を見るをチェック時、詳細画面表示メソッド
         */
         private function detailCheckBoxChangeHander(event:Event):void {
         	if (!_isDetailCheckBox) { //true
	         	_isDetailCheckBox = true;
	         	showTimesheetDetail(true);
         	} else {				  //false
	         	_isDetailCheckBox = false;
	         	showTimesheetDetail(false);
         	}
         }

		/**
		 * 勤務表詳細表示メソッド
		 */
         private function showTimesheetDetail(isDetail:Boolean):void {
         	/*
         	_document.overtimeAdvancedDataGridColumn.visible = isDetail;
         	_document.nightAdvancedDataGridColumn.visible = isDetail;
         	_document.holidayGridColumn.visible = isDetail;
         	_document.lateAndEarlyGridColumn.visible = isDetail;
         	*/
         }
    }
}