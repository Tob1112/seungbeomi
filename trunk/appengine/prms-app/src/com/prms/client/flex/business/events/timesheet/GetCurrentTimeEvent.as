package com.prms.client.flex.business.events.timesheet {
    import com.adobe.cairngorm.control.CairngormEvent;
    import com.prms.client.flex.views.timesheet.admin.AdminTimesheetList;
    import com.prms.client.flex.vo.Timesheet;

    public class GetCurrentTimeEvent extends CairngormEvent {
        static public var EVENT_ID:String = "getCurrentTimeEvent";
        public var timesheet:Timesheet;
        public var doc:AdminTimesheetList;

        public function GetCurrentTimeEvent(doc:AdminTimesheetList = null):void {
            super(EVENT_ID);
            this.doc = doc;
        }

    }
}