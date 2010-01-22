package com.prms.model {
    import mx.collections.ArrayCollection;

    [Bindable]
    public class AccountModelLocator {
        public var accountUserName:String; 			// ユーザー名前
        public var accountPassword:String; 			// ユーザーパスワード
        public var accountNewPassword:String; 		// ユーザー新パスワード

        // Admin
        public var accountAdminCompanyFlg:String; 	// 会社コード、
        public var empNo:String; 					// 社員番号
        public var lastName:String; 				// 名前（姓
        public var firstName:String; 				// 名前（名
        public var email:String; 					// メール
        public var role:String; 					// 権限
        public var deptName:String; 				// 部署名
        public var deptCode:String; 				// 部署番号
        public var hireDay:String; 					// 入社日
        public var validateName:String 				// 妥当性チェック用

        [Bindable]
        public var accountAdminAC:ArrayCollection = new ArrayCollection();

        static private var _instance:AccountModelLocator = null;

        static public function getInstance():AccountModelLocator {
            if (_instance == null) {
                _instance = new AccountModelLocator();
            }
            return _instance;
        }
    }
}