package com.prms.business.commands.timesheet {
    import com.adobe.cairngorm.commands.ICommand;
    import com.adobe.cairngorm.control.CairngormEvent;
    import com.prms.business.delegates.TimesheetDelegate;
    import com.prms.model.TimesheetModelLocator;
    import com.prms.util.Message;
    import com.prms.util.fommater.EmpNameFormatter;
    import com.prms.vo.Timesheet;

    import mx.rpc.Responder;
    import mx.rpc.events.FaultEvent;
    import mx.rpc.events.ResultEvent;

    /**
     * 	セッションから社員名取得
     */
    public class GetEmpNameCommand implements ICommand {
        private var model:TimesheetModelLocator = TimesheetModelLocator.getInstance();

        public function execute(event:CairngormEvent):void {
            var responder:Responder = new Responder(getEmpNameResultHandler, getEmpNameFaultHandler);
            var delegate:TimesheetDelegate = new TimesheetDelegate(responder);

            delegate.getEmpNameBySession();
        }

        /**
         * 	社員名取得を成功した場合
         */
        private function getEmpNameResultHandler(event:ResultEvent):void {
            var result:Timesheet = event.result as Timesheet;

            if (result != null) {
                model.timesheet.lastName = result.lastName;
                model.timesheet.firstName = result.firstName;
                model.timesheet.empNo = result.empNo;
                model.timesheet.comCode = result.comCode;
                model.timesheet.empName = EmpNameFormatter.setEmpName(model.timesheet.lastName, model.timesheet.firstName);
            }
        }


        /**
         * 	社員名取得を失敗した場合
         */
        private function getEmpNameFaultHandler(event:FaultEvent):void {
            //Alert.show(Message.SERVER_ACCESS_ERROR_MESSAGE);
            Message.showErrorMessage(event);
        }
    }
}