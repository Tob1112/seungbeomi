package com.prms.client.flex.views.timesheet.user.handlers {
    import com.prms.client.flex.Constants;
    import com.prms.client.flex.business.events.timesheet.GetCurrentTimeEvent;
    import com.prms.client.flex.business.events.timesheet.TimesheetEvent;
    import com.prms.client.flex.business.events.timesheet.WriteNewUserTimesheetEvent;
    import com.prms.client.flex.model.TimesheetModelLocator;
    import com.prms.client.flex.util.LayoutSizeUtil;
    import com.prms.client.flex.util.ViewStackChangeController;
    import com.prms.client.flex.views.timesheet.user.UserTimesheetList;
    import com.prms.client.flex.views.timesheet.user.UserTimesheetMain;
    import com.prms.client.flex.vo.Account;
    import com.prms.client.flex.vo.Timesheet;

    import flash.events.KeyboardEvent;
    import flash.events.MouseEvent;

    import mx.controls.DataGrid;
    import mx.core.IMXMLObject;
    import mx.core.ScrollPolicy;
    import mx.events.FlexEvent;
    import mx.events.ListEvent;

    public class UserTimesheetListHandler implements IMXMLObject {

        [Bindable] public var model:TimesheetModelLocator = TimesheetModelLocator.getInstance();
        private var timesheet:Timesheet;
        private var toDateYyyymm:Date;
        private var _document:UserTimesheetList;
        private var _account:Account;

        public function initialized(document:Object, id:String):void {
            _document = document as UserTimesheetList;
            _document.addEventListener(FlexEvent.CREATION_COMPLETE, creationCompleteHandler);
        }


        /**
         * 	入力した文字型日付をDate型で変換
         */
        private function setTxtYyyymm():void{
            //  toDateYyyymm = new Date(_document.txtYear.text, Number(_document.txtMonth.text) - 1);
        }


        /**
         * 	勤務表一覧取得
         */
        private function creationCompleteHandler(event:FlexEvent):void {
            setComponentValue();
            setComponentSize();
            addEventListenerProcess();
            dispatchEventProcess();

        }

        private function addEventListenerProcess():void{
            _document.addEventListener(FlexEvent.UPDATE_COMPLETE, updateCompleteHandler);
            // _document.currentDateLabel.addEventListener(
            // _document.txtMonth.addEventListener(KeyboardEvent.KEY_UP, activeBtnWorkList);
            // _document.txtYear.addEventListener(KeyboardEvent.KEY_UP, activeBtnWorkList);
            _document.dataGrid.addEventListener(ListEvent.ITEM_DOUBLE_CLICK, timesheetListDoubleClickHandler);
            _document.newWriteButton.addEventListener(MouseEvent.CLICK, timesheetNewWriteButtonHandler);
        }

        private function dispatchEventProcess():void{
            // 勤務表一覧取得
            // var loadEvent:LoadTimesheetListEvent = new LoadTimesheetListEvent();
            // loadEvent.dispatch();
            var timesheetEvent:TimesheetEvent = new TimesheetEvent(TimesheetEvent.USER_TIMESHEET_LIST);
            timesheetEvent.dispatch();

            // 現在の日付取得
            var currentTimeEvent:GetCurrentTimeEvent = new GetCurrentTimeEvent();
            currentTimeEvent.dispatch();

            // _document.currentDateLabel.text = model.timesheet.currentDateTypeIsString;
        }

        private function updateCompleteHandler(event:FlexEvent):void{
            setComponentSize();
        }

        private function setComponentValue():void{
            //styleName
            _document.styleName = "moduleContents";
            _document.titleLabel.styleName = "utTitleText";
            _document.topOutBox.styleName = "utTopOutBox";
            _document.currentDateBox.styleName = "utCurrentDateBox";
            _document.topInnerBox.styleName = "utTopInnerBox";
            _document.footerBox.styleName = "utFooterBox";
            _document.bodyBox.styleName = "utBodyBox";

            _document.horizontalScrollPolicy = ScrollPolicy.OFF;
            _document.verticalScrollPolicy = ScrollPolicy.OFF;

            _document.titleLabel.text = "勤務表一覧";

            // _document.txtYear.text = String(model.timesheet.currentDate.getFullYear());
            // _document.txtMonth.text = String(model.timesheet.currentDate.getMonth()+1)
            _document.newWriteButton.label = "新規作成";
            _account = _document.parentDocument.model.account;

        }

        private function setComponentSize():void{
            /** header */
            // header Outer
            _document.topOutBox.width = 300;
            _document.topOutBox.height = 80;
            // header currentDateBox
            _document.currentDateBox.width = 200;
            // header currentDateLabel
            _document.currentDateLabel.width = _document.currentDateBox.width - 10;
            // header Inner
            _document.topInnerBox.width = _document.topOutBox.width;

            /** footer */
            // footer Box
            _document.footerBox.height = LayoutSizeUtil.moduleContentHeight() * 0.05;
            _document.pagingLabel.width = _document.footerBox.width * 0.98;

            /**body */
            // dataGridBox
            _document.bodyBox.height = LayoutSizeUtil.moduleContentHeight() * 0.80;
            _document.bodyBox.setStyle("top", _document.topOutBox.height + 15);
            _document.bodyBox.setStyle("bottom", _document.footerBox.height + 15);
            // dataGrid
            _document.dataGrid.width = _document.bodyBox.width * 0.95;

        }


        /**
         * 	新規作成ボタンを押下したとき、
         */
        private function timesheetNewWriteButtonHandler(event:MouseEvent):void {
            timesheet = new Timesheet;
            setTxtYyyymm();

            timesheet.yyyymm = toDateYyyymm;
            model.yyyymm = timesheet.yyyymm;
            timesheet.lastName = "";
            timesheet.firstName = "";

            var newWriteEvent:WriteNewUserTimesheetEvent = new WriteNewUserTimesheetEvent(timesheet, _document);
            newWriteEvent.dispatch();
        }

        /**
         * 勤務表一覧をダブルクリックした場合
         *
         */
        private function timesheetListDoubleClickHandler(event:ListEvent):void {
            var target:DataGrid = event.currentTarget as DataGrid;
            var status:String = target.selectedItem.statusCode;

            model.timesheet.yyyymm = target.selectedItem.yyyymm;
            model.timesheet.codeDetailName = target.selectedItem.codeDetailName;
            // CodeName取得のため、設定
            model.timesheet.statusCode = status;
            model.timesheet.lastName = "";
            model.timesheet.firstName = "";

            if (status == Constants.STATUS_WRITE) { // 作成中
                model.statusFlg = Constants.STATUS_WRITING; // 編集可能
            } else if ((status == Constants.STATUS_WAIT_APPROVAL) ||	// 承認待ち
                (status == Constants.STATUS_COMPLETE_APPROVAL) ||	// 承認済み
                (status == Constants.STATUS_EDIT_ADMIN)) { // 管理者編集中
                model.statusFlg = Constants.STATUS_READING; // 読み取り
            }
            // 勤務表詳細画面に移動
            //  TimesheetViewStackController.viewstackChange(_document.parentDocument, Constants.USER_TIMESHEET_DETAILS, true);
            ViewStackChangeController.viewstackChange(UserTimesheetMain(_document.parentDocument), Constants.USER_TIMESHEET_DETAILS);
        }

        /**
         * 「年」、「月」の入力チェック
         */
        private function activeBtnWorkList(event:KeyboardEvent):void {
        /*    if ((_document.txtYear.length == 4) && (_document.txtMonth.length == 1 || _document.txtMonth.length == 2) && (0 < int(_document.txtMonth.text)) && (int(_document.txtMonth.text) < 13)) {
           _document.timesheetNewWriteButton.enabled = true;
           } else if ((_document.txtMonth.length == 0)) {
           _document.timesheetNewWriteButton.enabled = false;
           } else {
           _document.timesheetNewWriteButton.enabled = false;
         } */
        }
    }
}

