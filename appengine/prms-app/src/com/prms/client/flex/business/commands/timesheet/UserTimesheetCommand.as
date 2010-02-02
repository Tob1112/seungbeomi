package com.prms.client.flex.business.commands.timesheet
{
    import com.adobe.cairngorm.commands.ICommand;
    import com.adobe.cairngorm.control.CairngormEvent;
    import com.prms.client.flex.business.delegates.TimesheetDelegate;
    import com.prms.client.flex.business.events.timesheet.TimesheetEvent;
    import com.prms.client.flex.model.TimesheetModelLocator;
    import com.prms.client.flex.util.Message;
    import com.prms.client.flex.vo.Timesheet;

    import mx.collections.ArrayCollection;
    import mx.collections.IViewCursor;
    import mx.rpc.Responder;
    import mx.rpc.events.FaultEvent;
    import mx.rpc.events.ResultEvent;

    public class UserTimesheetCommand implements ICommand
    {
        private var _model:TimesheetModelLocator = TimesheetModelLocator.getInstance();
        public function execute(event:CairngormEvent):void {
            var responder:Responder = null;
            var delegate:TimesheetDelegate = null;

            switch (event.type) {
                // 勤務表一覧
                case TimesheetEvent.USER_TIMESHEET_LIST:
                    var timesheetEvent:TimesheetEvent = TimesheetEvent(event);
                    responder = new Responder(TimesheetListResultHandler, TimesheetListFaultHandler);
                    delegate = new TimesheetDelegate(responder);
                    delegate.getTimesheetList();
                    break;
                case TimesheetEvent.USER_TIMESHEET_DETAILS:
                    break;
            }
        }// end execute


        // 勤務表一覧 → 成功時
        private function TimesheetListResultHandler(event:ResultEvent):void{
            if (_model.timesheetAC != null) {
                _model.timesheetAC.removeAll();
            }

            var result:ArrayCollection = event.result as ArrayCollection;
            if (result != null) {
                var cursor:IViewCursor = result.createCursor();
                var listSeq:int = 0;

                while (!cursor.afterLast) {
                    listSeq++; // 勤務表一覧番号
                    var timesheet:Timesheet = cursor.current as Timesheet;
                    timesheet.listSeq = listSeq;
                    _model.timesheet = timesheet;
                    _model.timesheetAC.addItem(timesheet);
                    cursor.moveNext();
                }
            }

        }// end TimesheetListResultHandler

        // 勤務表一覧 → 失敗時
        private function TimesheetListFaultHandler(event:FaultEvent):void{
            Message.showErrorMessage(event);
        }// end TimesheetListFaultHandler
    }
}

