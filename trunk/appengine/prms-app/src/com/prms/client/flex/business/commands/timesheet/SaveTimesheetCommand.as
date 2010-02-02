package com.prms.client.flex.business.commands.timesheet {
    import com.adobe.cairngorm.commands.ICommand;
    import com.adobe.cairngorm.control.CairngormEvent;
    import com.prms.client.flex.business.delegates.TimesheetDelegate;
    import com.prms.client.flex.business.events.timesheet.SaveTimesheetEvent;
    import com.prms.client.flex.model.TimesheetModelLocator;
    import com.prms.client.flex.util.FileLoadWindow;
    import com.prms.client.flex.util.Message;
    import com.prms.client.flex.vo.FixTime;
    import com.prms.client.flex.vo.Timesheet;
    import com.prms.client.flex.vo.TimesheetDetail;

    import mx.collections.IViewCursor;
    import mx.controls.Alert;
    import mx.managers.CursorManager;
    import mx.managers.PopUpManager;
    import mx.rpc.Responder;
    import mx.rpc.events.FaultEvent;
    import mx.rpc.events.ResultEvent;

    public class SaveTimesheetCommand implements ICommand {
        private var model:TimesheetModelLocator = TimesheetModelLocator.getInstance();

        public function execute(event:CairngormEvent):void {
			var responder:Responder = null;
			var delegate:TimesheetDelegate = null;
			var vo:Timesheet = null;


			switch(event.type) {
			case SaveTimesheetEvent.SAVE_TIMESHEET_EVENT:	// 勤務表保存
	            responder = new Responder(saveTimesheetResultHandler, serviceFaultHandler);
	            delegate = new TimesheetDelegate(responder);
	            vo = sendTimesheet(SaveTimesheetEvent(event).vo);
	            delegate.saveTimesheet(vo);
				break;
			case SaveTimesheetEvent.SAVE_UPLOAD_TIMESHEET_EVENT:	//ファイルアップロードから勤務表保存
	            responder = new Responder(saveUploadTimesheetResultHandler, serviceFaultHandler);
	            delegate = new TimesheetDelegate(responder);
	            vo = sendTimesheet(SaveTimesheetEvent(event).vo);
	            delegate.saveUploadTimesheet(vo);
				break;
			}
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
            model.timesheet.codeDetailName = "作成中";
            Alert.show(message.msgBody, "INFO : " + message.msgType + "-" + message.msgId);
        }

		/** ファイルアップロードの保存 */
        private function saveUploadTimesheetResultHandler(event:ResultEvent):void {
        	model.timesheet = null;
			var vo:Timesheet = event.result as Timesheet;
			model.timesheet = vo;
			CursorManager.removeBusyCursor();
        }

        /**
         * 保存失敗時の処理
         * @param event FaultEvent
         */
        private function serviceFaultHandler(event:FaultEvent):void {
            Message.showErrorMessage(event);
            CursorManager.removeBusyCursor();
        }
    }
}

