package com.prms.client.flex.business.events.timesheet {

    import com.adobe.cairngorm.control.CairngormEvent;
    import com.prms.client.flex.views.timesheet.admin.AdminTimesheetList;
    import com.prms.client.flex.vo.Timesheet;

    public class LoadTimesheetListEvent extends CairngormEvent {

        static public var EVENT_ID:String = "loadTimesheetListEvent";
        public var timesheet:Timesheet;
        public var doc:AdminTimesheetList;

        public function LoadTimesheetListEvent(timesheet:Timesheet = null, doc:AdminTimesheetList = null) {
            super(EVENT_ID);
            this.timesheet = timesheet;
            this.doc = doc;
        }
    }
}

