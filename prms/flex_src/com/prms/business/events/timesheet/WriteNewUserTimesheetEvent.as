package com.prms.business.events.timesheet {
    import com.adobe.cairngorm.control.CairngormEvent;
    import com.prms.views.timesheet.user.UserTimesheetList;
    import com.prms.vo.Timesheet;

    public class WriteNewUserTimesheetEvent extends CairngormEvent {
        static public var EVENT_ID:String = "newWriteEvent";
        public var timesheet:Timesheet;
        public var document:UserTimesheetList;

        public function WriteNewUserTimesheetEvent(timesheet:Timesheet, document:UserTimesheetList) {
            super(EVENT_ID);
            this.timesheet = timesheet;
            this.document = document;
        }
    }
}