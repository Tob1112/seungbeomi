package com.prms.business.events.main {
    import com.adobe.cairngorm.control.CairngormEvent;
    import com.prms.views.main.admin.AdminMainLayout;
    import com.prms.vo.Main;

    public class AdminMainHeaderEvent extends CairngormEvent {
        static public var EVENT_ID:String = "adminMainHeaderSelectedEvent";
        public var adminMain:Main;
        public var doc:AdminMainLayout;

        public function AdminMainHeaderEvent(adminMain:Main, doc:AdminMainLayout) {
            super(EVENT_ID);
            this.adminMain = adminMain;
            this.doc = doc;
        }
    }
}