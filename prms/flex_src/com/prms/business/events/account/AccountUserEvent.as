package com.prms.business.events.account {
    import com.adobe.cairngorm.control.CairngormEvent;
    import com.prms.views.account.user.AccountUserBody;
    import com.prms.vo.AccountUser;

    /**
     *
     * @author DEV006
     */
    public class AccountUserEvent extends CairngormEvent {
        static public var EVENT_ID:String = "accountUserEvent";
        public var account:AccountUser;
        public var doc:AccountUserBody;

        /**
         *
         * @param account
         * @param doc
         */
        public function AccountUserEvent(account:AccountUser, doc:AccountUserBody) {
            super(EVENT_ID);
            this.account = account;
            this.doc = doc;
        }
    }
}