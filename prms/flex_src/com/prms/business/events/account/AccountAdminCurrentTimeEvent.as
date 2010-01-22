package com.prms.business.events.account {
    import com.adobe.cairngorm.control.CairngormEvent;
    import com.prms.views.account.admin.AccountAdminList;

    /**
     *  ユーザー情報出力イベント(アカウント)
     */
    public class AccountAdminCurrentTimeEvent extends CairngormEvent {
        static public var EVENT_ID:String = "accountAdminCurrentTimeEvent";
        public var doc:AccountAdminList;

        public function AccountAdminCurrentTimeEvent(doc:AccountAdminList) {
            super(EVENT_ID);
            this.doc = doc;
        }
    }
}