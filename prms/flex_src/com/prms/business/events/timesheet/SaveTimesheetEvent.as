package com.prms.business.events.timesheet {
    import com.adobe.cairngorm.control.CairngormEvent;
    import com.prms.views.timesheet.user.UserTimesheetDetails;
    import com.prms.vo.Timesheet;

    /**
     * 保存ボタンクリック時のEvnet
     * @author developer002
     */
    public class SaveTimesheetEvent extends CairngormEvent {
        static public var EVENT_ID:String = "saveTimesheetEvent";
        public var timesheetVO:Timesheet;

        public function SaveTimesheetEvent(timesheetVO:Timesheet) {
            super(EVENT_ID);
            this.timesheetVO = timesheetVO;
        }
    }
}

