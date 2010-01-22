package com.prms.views.timesheet.user.handlers {
    import com.prms.Constants;
    import com.prms.business.events.timesheet.GetCurrentTimeEvent;
    import com.prms.business.events.timesheet.LoadTimesheetListEvent;
    import com.prms.business.events.timesheet.WriteNewUserTimesheetEvent;
    import com.prms.model.TimesheetModelLocator;
    import com.prms.util.ViewStackChangeController;
    import com.prms.views.timesheet.user.UserTimesheetList;
    import com.prms.views.timesheet.user.UserTimesheetMain;
    import com.prms.vo.Timesheet;

    import flash.events.KeyboardEvent;
    import flash.events.MouseEvent;

    import mx.controls.DataGrid;
    import mx.core.IMXMLObject;
    import mx.events.FlexEvent;
    import mx.events.ListEvent;

    public class UserTimesheetListHandler implements IMXMLObject {
        [Bindable]
        private var timesheetCurrentDate:Date = new Date();
        [Bindable]
        public var model:TimesheetModelLocator = TimesheetModelLocator.getInstance();
        private var timesheet:Timesheet;
        private var toDateYyyymm:Date;
        private var document:UserTimesheetList;

        /**
         * 	イベントリスナー登録
         */
        public function initialized(document:Object, id:String):void {
            this.document = document as UserTimesheetList;
            this.document.addEventListener(FlexEvent.CREATION_COMPLETE, timesheetListLoadHandler);
        }


        /**
         * 	入力した文字型日付をDate型で変換
         */
        private function setTxtYyyymm():void {
            toDateYyyymm = new Date(this.document.txtYear.text, Number(this.document.txtMonth.text) - 1);
        }


        /**
         * 	勤務表一覧取得
         */
        private function timesheetListLoadHandler(event:FlexEvent):void {

            this.document.txtMonth.addEventListener(KeyboardEvent.KEY_UP, activeBtnWorkList);
            this.document.txtYear.addEventListener(KeyboardEvent.KEY_UP, activeBtnWorkList);
            this.document.timesheetListDataGrid.addEventListener(ListEvent.ITEM_DOUBLE_CLICK, timesheetListDoubleClickHandler);
            this.document.timesheetNewWriteButton.addEventListener(MouseEvent.CLICK, timesheetNewWriteButtonHandler);

            // 勤務表一覧ロード
            var loadEvent:LoadTimesheetListEvent = new LoadTimesheetListEvent(model.timesheet);
            loadEvent.dispatch();

            // 現在の日付取得
            var getCurrentTimeEvent:GetCurrentTimeEvent = new GetCurrentTimeEvent();
            getCurrentTimeEvent.dispatch();
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

            var newWriteEvent:WriteNewUserTimesheetEvent = new WriteNewUserTimesheetEvent(timesheet, this.document);
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
            ViewStackChangeController.viewstackChange(UserTimesheetMain(this.document.parentDocument), Constants.USER_TIMESHEET_DETAILS);
        }

        /**
         * 「年」、「月」の入力チェック
         */
        private function activeBtnWorkList(event:KeyboardEvent):void {
            if ((this.document.txtYear.length == 4) && (this.document.txtMonth.length == 1 || this.document.txtMonth.length == 2) && (0 < int(this.document.txtMonth.text)) && (int(this.document.txtMonth.text) < 13)) {
                this.document.timesheetNewWriteButton.enabled = true;
            } else if ((this.document.txtMonth.length == 0)) {
                this.document.timesheetNewWriteButton.enabled = false;
            } else {
                this.document.timesheetNewWriteButton.enabled = false;
            }
        }
    }
}