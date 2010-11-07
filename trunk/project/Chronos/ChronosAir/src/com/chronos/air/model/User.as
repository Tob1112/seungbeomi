package com.chronos.air.model
{
	[RemoteClass(alias="com.chronos.appengine.domain.User")]
	[Bindable]
	public class User
	{
		public var id:String;
		public var password:String;
		public var name:String;
		public var rememberMe:Boolean;

		public function reset():void {
			id = "";
			password = "";
			name = "";
			rememberMe = false;
		}
	}
}