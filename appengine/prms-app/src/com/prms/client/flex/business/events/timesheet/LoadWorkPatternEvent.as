package com.prms.client.flex.business.events.timesheet {
    import com.adobe.cairngorm.control.CairngormEvent;

    public class LoadWorkPatternEvent extends CairngormEvent {
        public static var EVENT_ID:String = "loadWorkPatternEvent";

        public function LoadWorkPatternEvent() {
            super(EVENT_ID);
        }

    }
}