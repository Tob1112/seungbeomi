package com.prms.business.commands.timesheet {
    import com.adobe.cairngorm.commands.ICommand;
    import com.adobe.cairngorm.control.CairngormEvent;
    import com.prms.business.delegates.TimesheetDelegate;
    import com.prms.business.events.timesheet.GetCurrentTimeEvent;
    import com.prms.model.LoginModelLocator;
    import com.prms.model.TimesheetModelLocator;
    import com.prms.util.Message;
    import com.prms.views.timesheet.admin.AdminTimesheetList;
    import com.prms.vo.Timesheet;

    import mx.rpc.Responder;
    import mx.rpc.events.FaultEvent;
    import mx.rpc.events.ResultEvent;

    /**
     * 	セッションから現在の日付を取得
     */
    public class GetCurrentTimeCommand implements ICommand {
        private var model:TimesheetModelLocator = TimesheetModelLocator.getInstance();
        private var loginModel:LoginModelLocator = LoginModelLocator.getInstance();
        private var timesheet:Timesheet;
        private var currentYear:Number;
        private var currentMonth:Number;
        private var currentDayOfMonth:Number;
        private var dayOfWkArray:Array = new Array("日", "月", "火", "水", "木", "金", "土");
        private var doc:AdminTimesheetList;

        public function execute(event:CairngormEvent):void {

        	if (loginModel.account.isAdmin()) {
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
            if (loginModel.account.isAdmin()) {
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
            //Alert.show(Message.SERVER_ACCESS_ERROR_MESSAGE);
            Message.showErrorMessage(event);
        }
    }
}