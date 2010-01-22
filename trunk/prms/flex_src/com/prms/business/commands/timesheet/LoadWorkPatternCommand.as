package com.prms.business.commands.timesheet {
    import com.adobe.cairngorm.commands.ICommand;
    import com.adobe.cairngorm.control.CairngormEvent;
    import com.prms.business.delegates.PrmsDelegate;
    import com.prms.business.delegates.TimesheetDelegate;
    import com.prms.model.TimesheetModelLocator;
    import com.prms.util.Message;

    import mx.collections.ArrayCollection;
    import mx.rpc.Responder;
    import mx.rpc.events.FaultEvent;
    import mx.rpc.events.ResultEvent;

    /**
     * 勤務表表示時の勤務形態取得の処理
     * @auther 孫承範
     */
    public class LoadWorkPatternCommand implements ICommand {
        private var _model:TimesheetModelLocator = TimesheetModelLocator.getInstance();

        public function execute(event:CairngormEvent):void {
            var responder:Responder = new Responder(loadWorkPatternResultHandler, loadWorkPatternFaultHandler);
            var delegate:TimesheetDelegate = new TimesheetDelegate(responder);
            delegate.getWorkPattern();
        }

        /**
         * 勤務形態ロード成功処理
         */
        private function loadWorkPatternResultHandler(event:ResultEvent):void {
            _model.codeDetailAC = event.result as ArrayCollection;
        }

        /**
         * 勤務形態ロード失敗処理
         */
        private function loadWorkPatternFaultHandler(event:FaultEvent):void {
            //Alert.show(event.toString());
            Message.showErrorMessage(event);
        }
    }
}