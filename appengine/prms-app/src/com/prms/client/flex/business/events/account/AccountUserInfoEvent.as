package com.prms.client.flex.business.events.account {
    import com.adobe.cairngorm.control.CairngormEvent;
    import com.prms.client.flex.views.account.user.AccountUserBody;

    /**
     *  ユーザー情報出力イベント(アカウント)
     */
    public class AccountUserInfoEvent extends CairngormEvent {
        static public var EVENT_ID:String = "accountUserInfoEvent";
        public var doc:AccountUserBody;

        public function AccountUserInfoEvent(doc:AccountUserBody) {
            super(EVENT_ID);
            this.doc = doc;
        }
    }
}