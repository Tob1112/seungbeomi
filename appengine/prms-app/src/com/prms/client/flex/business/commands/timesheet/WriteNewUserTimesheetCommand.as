package com.prms.client.flex.business.commands.timesheet {
    import com.adobe.cairngorm.commands.ICommand;
    import com.adobe.cairngorm.control.CairngormEvent;
    import com.prms.client.flex.Constants;
    import com.prms.client.flex.business.delegates.TimesheetDelegate;
    import com.prms.client.flex.business.events.timesheet.WriteNewUserTimesheetEvent;
    import com.prms.client.flex.model.TimesheetModelLocator;
    import com.prms.client.flex.util.Message;
    import com.prms.client.flex.util.ViewStackChangeController;
    import com.prms.client.flex.views.timesheet.user.UserTimesheetList;
    import com.prms.client.flex.views.timesheet.user.UserTimesheetMain;
    import com.prms.client.flex.vo.Timesheet;

    import mx.controls.Alert;
    import mx.rpc.Responder;
    import mx.rpc.events.FaultEvent;
    import mx.rpc.events.ResultEvent;

    public class WriteNewUserTimesheetCommand implements ICommand {
        private var _model:TimesheetModelLocator = TimesheetModelLocator.getInstance();
        private var _timesheet:Timesheet;
        private var _document:UserTimesheetList;

        public function execute(event:CairngormEvent):void {
            var responder:Responder = new Responder(WriteNewTimesheetResultHandler, WriteNewTimesheetFaultHandler);
            var delegate:TimesheetDelegate = new TimesheetDelegate(responder);

            _timesheet = WriteNewUserTimesheetEvent(event).timesheet;
            _document = WriteNewUserTimesheetEvent(event).document;

            delegate.existTimesheetByYYYYMM(_timesheet);

        }

        /**
         * 新規作成成功の処理
         * （該当年月の勤務表がない場合）
         * @param event
         */
        private function WriteNewTimesheetResultHandler(event:ResultEvent):void {
            // 新規作成画面に遷移する。
            if (!event.result) {
                _model.statusFlg = Constants.STATUS_CREATION; // 新規作成
                _model.timesheet.codeDetailName = "新規作成";
                _model.timesheet.yyyymm = _model.yyyymm;

                // 勤務表詳細画面に移動
                ViewStackChangeController.viewstackChange(UserTimesheetMain(_document.parentDocument), Constants.USER_TIMESHEET_DETAILS);
            } else {
                Alert.show("指定された勤務表はすでに作成されています\n一覧から選択して下さい");
            }
        }

        /**
         * 新規作成失敗の処理
         * （該当年月の勤務表がある場合）
         * @param event
         */
        private function WriteNewTimesheetFaultHandler(event:FaultEvent):void {
            //Alert.show(Message.SERVER_ACCESS_ERROR_MESSAGE);
            Message.showErrorMessage(event);
        }
    }
}
