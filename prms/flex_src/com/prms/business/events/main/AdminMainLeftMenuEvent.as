package com.prms.business.events.main {
    import com.adobe.cairngorm.control.CairngormEvent;
    import com.prms.views.main.admin.AdminMainLayout;
    import com.prms.vo.Main;

    public class AdminMainLeftMenuEvent extends CairngormEvent {
        static public var EVENT_ID:String = "adminMainLeftMenuEvent";
        public var adminMainLeftMenu:Main;
        public var doc:AdminMainLayout;

        public function AdminMainLeftMenuEvent(adminMainLeftMenu:Main, doc:AdminMainLayout) {
            super(EVENT_ID);
            this.adminMainLeftMenu = adminMainLeftMenu;
            this.doc = doc;
        }
    }
}