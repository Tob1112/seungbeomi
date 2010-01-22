package com.prms.model {

    import com.prms.vo.Account;

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

