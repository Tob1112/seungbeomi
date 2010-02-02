package com.prms.client.flex.business.events.main {
    import com.adobe.cairngorm.control.CairngormEvent;
    import com.prms.client.flex.views.main.admin.AdminMainLayout;
    import com.prms.client.flex.vo.Main;

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