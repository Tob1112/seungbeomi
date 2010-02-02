package com.prms.client.flex.vo {
    import com.prms.client.flex.Constants;


    /**
     *
     * @author DEV006
     */
    [RemoteClass(alias="com.prms.server.model.Account")]
    [Bindable]
    public class Account {
        // User
        public var accountUserId:String; // ユーザー
        public var accountUserPassword:String; // 現在パスワード
        public var accountUserNewPassword:String; // 新しいパスワード

        // Admin
        public var accountAdminCompanyFlg:String; // 会社コード、
        public var empNo:String; // 社員番号
        public var lastName:String; // 名前（姓
        public var firstName:String; // 名前（名
        public var email:String; // メール
        public var roles:Array; // 権限
        public var deptName:String; // 部署名

        public var comCode:String;
        public var regDay:String;
        public var delDay:String;
        public var deptCode:String;
        public var passwd:String;
        public var hireDay:String;
        public var retireDay:String;
        public var latestFlag:String;

        public function isAdmin():Boolean {
            return hasRole(Constants.ROLE_ADMIN);
        }

        public function isUser():Boolean {
            return hasRole(Constants.ROLE_USER);
        }

        private function hasRole(role:String):Boolean {
            for (var i:String in roles) {
                if (roles[i] == role) {
                    return true;
                }
            }
            return false;
        }
    }
}