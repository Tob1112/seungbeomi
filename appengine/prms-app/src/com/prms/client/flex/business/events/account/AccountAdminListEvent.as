package com.prms.client.flex.business.events.account {
    import com.adobe.cairngorm.control.CairngormEvent;
    import com.prms.client.flex.views.account.admin.AccountAdminList;
    import com.prms.client.flex.vo.AccountUser;

    public class AccountAdminListEvent extends CairngormEvent {
        static public var EVENT_ID:String = "accountAdminListEvent";
        public var account:AccountUser;
        public var accountListDoc:AccountAdminList;

        public function AccountAdminListEvent(account:AccountUser, accountListDoc:AccountAdminList) {
            super(EVENT_ID);
            this.account = account;
            this.accountListDoc = accountListDoc;
        }
    }
}