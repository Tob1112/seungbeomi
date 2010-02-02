package com.prms.client.flex.business.commands.timesheet {
    import com.adobe.cairngorm.commands.ICommand;
    import com.adobe.cairngorm.control.CairngormEvent;
    import com.prms.client.flex.business.delegates.TimesheetDelegate;
    import com.prms.client.flex.business.events.timesheet.GetCurrentTimeEvent;
    import com.prms.client.flex.model.AccountModelLocator;
    import com.prms.client.flex.model.TimesheetModelLocator;
    import com.prms.client.flex.util.Message;
    import com.prms.client.flex.views.timesheet.admin.AdminTimesheetList;
    import com.prms.client.flex.vo.Timesheet;

    import mx.rpc.Responder;
    import mx.rpc.events.FaultEvent;
    import mx.rpc.events.ResultEvent;

    /**
     * 	セッションから現在の日付を取得
     */
    public class GetCurrentTimeCommand implements ICommand {
        private var model:TimesheetModelLocator = TimesheetModelLocator.getInstance();
        private var _accountModel:AccountModelLocator = AccountModelLocator.getInstance();
        private var timesheet:Timesheet;
        private var currentYear:Number;
        private var currentMonth:Number;
        private var currentDayOfMonth:Number;
        private var dayOfWkArray:Array = new Array("日", "月", "火", "水", "木", "金", "土");
        private var doc:AdminTimesheetList;

        public function execute(event:CairngormEvent):void {

            if (_accountModel.account.isAdmin()) {
                this.doc = GetCurrentTimeEvent(event).doc;
            }

            var responder:Responder = new Responder(getCurrentTimeResultHandler, serviceFaultHandler);
            var delegate:TimesheetDelegate = new TimesheetDelegate(responder);
            delegate.getCurrentTime();
        }

        /**
         * 	現在の日付取得を成功した場合
         */
        private function getCurrentTimeResultHandler(event:ResultEvent):void {

            var result:Timesheet = event.result as Timesheet;
            var currentDayOfWeek:String;

            currentYear = result.currentDate.getFullYear();
            currentMonth = result.currentDate.getMonth() + 1;
            currentDayOfMonth = result.currentDate.getDate();
            currentDayOfWeek = dayOfWk(currentDayOfMonth);

            model.timesheet.currentDate = result.currentDate;
            model.timesheet.currentDateTypeIsString = currentYear + "年 " + currentMonth + "月 " + currentDayOfMonth + "日 （ " + currentDayOfWeek + " ）";

            // 管理者勤務表画面のdatechooserに日付を設定
            if (_accountModel.account.isAdmin()) {
                // 今月戻る機能のため
                model.yyyymm = result.currentDate;

                this.doc.labelCurrentDate.text = model.timesheet.currentDateTypeIsString;
                this.doc.datechooserYYYYMM.displayedYear = result.currentDate.getFullYear();
                this.doc.datechooserYYYYMM.displayedMonth = result.currentDate.getMonth();
            }
        }

        /**
         * 	取得した現在の日付を文字列の曜日で変換
         */
        private function dayOfWk(dd:Number):String {
            var date:Date = new Date(currentYear, currentMonth - 1, currentDayOfMonth);

            return dayOfWkArray[date.day];
        }

        /**
         * 	現在の日付取得を失敗した場合
         */
        private function serviceFaultHandler(event:FaultEvent):void {
            Message.showErrorMessage(event);
        }
    }
}

