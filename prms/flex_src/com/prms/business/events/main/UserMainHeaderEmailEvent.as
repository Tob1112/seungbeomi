package com.prms.business.events.main {
    import com.adobe.cairngorm.control.CairngormEvent;
    import com.prms.views.main.user.UserMainLayout;

    /**
     *
     * @author DEV006
     */
    public class UserMainHeaderEmailEvent extends CairngormEvent {
        static public var USER_MAIN_EMAIL_EVENT:String = "userMainHeaderEmailEvent";
        public var doc:UserMainLayout;

        /**
         *
         * @param doc
         */
        public function UserMainHeaderEmailEvent(doc:UserMainLayout) {
            super(USER_MAIN_EMAIL_EVENT);
            this.doc = doc;
        }
    }
}