package com.prms.business.events.main {
    import com.adobe.cairngorm.control.CairngormEvent;
    import com.prms.views.main.user.UserMainLayout;
    import com.prms.vo.Main;

    /**
     *
     * @author DEV006
     */
    public class UserMainHeaderEvent extends CairngormEvent {
        static public var EVENT_ID:String = "userMainHeaderSelectedEvent";
        public var main:Main;
        public var doc:UserMainLayout;

        /**
         *
         * @param main
         * @param doc
         */
        public function UserMainHeaderEvent(main:Main, doc:UserMainLayout) {
            super(EVENT_ID);
            this.main = main;
            this.doc = doc;
        }
    }
}