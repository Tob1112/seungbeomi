package com.prms.client.flex.business.events.timesheet {
    import com.adobe.cairngorm.control.CairngormEvent;
    import com.prms.client.flex.vo.Timesheet;

    public class GetEmpNameEvent extends CairngormEvent {
        static public var EVENT_ID:String = "getEmpNameEvent";
        public var timesheet:Timesheet;

        public function GetEmpNameEvent(timesheet:Timesheet) {
            super(EVENT_ID);
            this.timesheet = timesheet;
        }

    }
}