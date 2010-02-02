package com.prms.client.flex.business.events.timesheet {
    import com.adobe.cairngorm.control.CairngormEvent;
    import com.prms.client.flex.util.FileLoadWindow;
    import com.prms.client.flex.vo.Timesheet;

    /**
     * 保存ボタンクリック時のEvnet
     * @author developer002
     */
    public class SaveTimesheetEvent extends CairngormEvent {
        static public var SAVE_TIMESHEET_EVENT:String = "saveTimesheetEvent";
        static public var SAVE_UPLOAD_TIMESHEET_EVENT:String = "saveUploadTimesheetEvent";
        public var vo:Timesheet;

        public function SaveTimesheetEvent(type:String, vo:Timesheet=null, popup:FileLoadWindow=null) {
            super(type);
            this.vo = vo;

        }
    }
}

