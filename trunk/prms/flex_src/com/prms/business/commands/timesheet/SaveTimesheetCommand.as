package com.prms.business.commands.timesheet {
    import com.adobe.cairngorm.commands.ICommand;
    import com.adobe.cairngorm.control.CairngormEvent;
    import com.prms.business.delegates.PrmsDelegate;
    import com.prms.business.delegates.TimesheetDelegate;
    import com.prms.business.events.timesheet.SaveTimesheetEvent;
    import com.prms.model.TimesheetModelLocator;
    import com.prms.util.Message;
    import com.prms.vo.FixTime;
    import com.prms.vo.Timesheet;
    import com.prms.vo.TimesheetDetail;

    import mx.collections.IViewCursor;
    import mx.controls.Alert;
    import mx.rpc.Responder;
    import mx.rpc.events.FaultEvent;
    import mx.rpc.events.ResultEvent;

    public class SaveTimesheetCommand implements ICommand {
        private var _model:TimesheetModelLocator = TimesheetModelLocator.getInstance();

        public function execute(event:CairngormEvent):void {
            var responder:Responder = new Responder(saveTimesheetResultHandler, saveTimesheetFaultHandler);
            var delegate:TimesheetDelegate = new TimesheetDelegate(responder);
            var timesheet:Timesheet = sendTimesheet(SaveTimesheetEvent(event).timesheetVO);
            delegate.saveTimesheet(timesheet);
        }

        /**
         * サーバ側に送るデータを作成
         * @param timesheet 勤務表（月）
         * @return 勤務表（月）Entity
         */
        private function sendTimesheet(timesheet:Timesheet):Timesheet {
            var timesheetCursor:IViewCursor = timesheet.timesheetDetailList.createCursor();
            var fixCursor:IViewCursor = timesheet.fixTimeList.createCursor();
            // 勤務表（日）
            while (!timesheetCursor.afterLast) {
                var dd:TimesheetDetail = timesheetCursor.current as TimesheetDetail;
                TimesheetDetail(timesheetCursor.current).workStartTime = removeColon(dd.workStartTime);
                TimesheetDetail(timesheetCursor.current).workEndTime = removeColon(dd.workEndTime);
                TimesheetDetail(timesheetCursor.current).breakTimeTotal = removeColon(dd.breakTimeTotal);
                timesheetCursor.moveNext();
            }
            // 定時情報
            while (!fixCursor.afterLast) {
                var fixTime:FixTime = fixCursor.current as FixTime;
                FixTime(fixCursor.current).workStartTime = removeColon(fixTime.workStartTime);
                FixTime(fixCursor.current).workEndTime = removeColon(fixTime.workEndTime);
                FixTime(fixCursor.current).lunchStartTime = removeColon(fixTime.lunchStartTime);
                FixTime(fixCursor.current).lunchEndTime = removeColon(fixTime.lunchEndTime);
                fixCursor.moveNext();
            }
            return timesheet;
        }

        /**
         * コロン(：)を削除する
         * @param str
         * @return
         */
        private function removeColon(str:String):String {
            if (str == null) {
                return null;
            }
            return str.replace(":", "");
        }

        /**
         * 保存成功時の処理
         * @param event ResultEvent
         */
        private function saveTimesheetResultHandler(event:ResultEvent):void {
            var message:Message = event.result as Message;
            _model.timesheet.codeDetailName = "作成中";
            Alert.show(message.msgBody, "INFO : " + message.msgType + "-" + message.msgId);
        }

        /**
         * 保存失敗時の処理
         * @param event FaultEvent
         */
        private function saveTimesheetFaultHandler(event:FaultEvent):void {
            //mx.controls.Alert.show(Message.SERVER_ACCESS_ERROR_MESSAGE);
            Message.showErrorMessage(event);
        }
    }
}

