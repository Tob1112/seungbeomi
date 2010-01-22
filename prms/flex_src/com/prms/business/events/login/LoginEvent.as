package com.prms.business.events.login {
    import com.adobe.cairngorm.control.CairngormEvent;
    import com.prms.views.login.LoginBody;
    import com.prms.vo.Account;


    public class LoginEvent extends CairngormEvent {

        public static const EVENT_ID:String = "login";

        public var account:Account;
        public var doc:LoginBody;

        public function LoginEvent(account:Account, doc:LoginBody) {
            super(EVENT_ID);
            this.account = account;
            this.doc = doc;
        }

    }
}

