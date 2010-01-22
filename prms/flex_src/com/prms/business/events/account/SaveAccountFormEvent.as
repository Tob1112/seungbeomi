package com.prms.business.events.account {
    import com.adobe.cairngorm.control.CairngormEvent;
    import com.prms.views.account.admin.SaveAccountAdmin;
    import com.prms.vo.AccountUser;

    public class SaveAccountFormEvent extends CairngormEvent {
        static public var EVENT_ID:String = "saveAccountFormEvent";
        public var account:AccountUser;
        public var saveAccountDoc:SaveAccountAdmin;

        public function SaveAccountFormEvent(account:AccountUser, saveAccountDoc:SaveAccountAdmin) {
            super(EVENT_ID);
            this.account = account;
            this.saveAccountDoc = saveAccountDoc;
        }
    }
}