package com.chronos.air.model
{
	[RemoteClass(alias="com.chronos.appengine.domain.User")]
	[Bindable]
	public class User
	{
		public var id:String;
		public var password:String;
		public var name:String;

	}
}