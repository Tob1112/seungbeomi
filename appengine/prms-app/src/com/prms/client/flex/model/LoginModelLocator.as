package com.prms.client.flex.model {

    import com.prms.client.flex.vo.Account;
    // TODO delete 予定(AccountModelを使うように変更)
    [Bindable]
    public class LoginModelLocator {


        public var account:Account;
        static private var _instance:LoginModelLocator = null;

        static public function getInstance():LoginModelLocator {
            if (_instance == null) {
                _instance = new LoginModelLocator();
            }
            return _instance;
        }
    }
}

