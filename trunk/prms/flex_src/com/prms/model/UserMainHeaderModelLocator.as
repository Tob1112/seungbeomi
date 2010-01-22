package com.prms.model {
    import com.prms.vo.Main;

    /**
     *
     * @author DEV006
     */
    [Bindable]
    public class UserMainHeaderModelLocator {
        public var main:String; 				// userMainHeader
        public var adminMain:String; 			// adminMainHeader
        public var adminMainLeftMenu:String; 	// adminMainLeftMenu

        static private var _instance:UserMainHeaderModelLocator = null;

        /**
         *
         * @return
         */
        static public function getInstance():UserMainHeaderModelLocator {
            if (_instance == null) {
                _instance = new UserMainHeaderModelLocator();
            }
            return _instance;
        }
    }
}