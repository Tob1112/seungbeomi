package com.prms.vo {

    /**
     *
     * @author DEV006
     */
    [RemoteClass(alias="com.prms.model.AccountUser")]
    [Bindable]
    public class AccountUser {
        // User
        public var accountUserName:String; 			// ユーザー
        public var accountUserPassword:String; 		// 現在パスワード
        public var accountUserNewPassword:String; 	// 新しいパスワード

        // Admin
        public var accountAdminCompanyFlg:String; 	// 会社コード、
        public var empNo:String; 					// 社員番号
        public var lastName:String; 				// 名前（姓
        public var firstName:String; 				// 名前（名
        public var email:String; 					// メール
        public var role:String; 					// 権限
        public var deptName:String; 				// 部署名

        public var validateName:String; 			// 妥当性チェック用

        public var comCode:String;
        public var regDay:String;
        public var delDay:String;
        public var deptCode:String;
        public var passwd:String;
        public var hireDay:String;
        public var retireDay:String;
        public var latestFlag:String;
        public var currentDate:Date;

    }
}