package com.chronos.air.model
{
	//[RemoteClass(alias="com.chronos.appengine.domain.Shain")]
	[RemoteClass(alias="com.chronos.domain.Shain")]
	[Bindable]
	public class Shain
	{
		public var id:String;			// id
		public var password:String;		// パスワード
		public var shainMei:String;		// 社員名
		public var rememberMe:Boolean;	// ログイン保存
		public var shainBango:String;	// 申請番号

		public function reset():void {
			id = "";
			password = "";
			shainMei = "";
			rememberMe = false;
			shainBango = "";
		}
	}
}