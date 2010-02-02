package com.prms.client.flex.business.events.timesheet {
    import com.adobe.cairngorm.control.CairngormEvent;
    import com.prms.client.flex.views.timesheet.admin.AdminTimesheetList;
    import com.prms.client.flex.vo.Timesheet;

    public class LoadTimesheetDetailsEvent extends CairngormEvent {

        static public var EVENT_ID:String = "loadTimesheetDetailsEvent"; //TODO eventID 修正

        public var vo:Timesheet;
        public var statusFlg:String;
        public var doc:AdminTimesheetList;

        /**
         *
         * @param vo
         * @param statusFlg 勤務表状態フラグ (新規01、作成中02, 読み取り専用03)
         */
        public function LoadTimesheetDetailsEvent(vo:Timesheet, statusFlg:String, doc:AdminTimesheetList = null) {
            super(EVENT_ID);
            this.vo = vo;
            this.statusFlg = statusFlg;
            this.doc = doc;
        }
    }
}

