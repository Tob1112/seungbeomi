package com.chronos.air.sample
{
	import flash.utils.ByteArray;

	[RemoteClass(alias="com.chronos.appengine.sample.FileUpDownLoad")]
	[Bindable]
	public class FileUpDownLoad
	{
		public var name:String;
		public var data:ByteArray;
	}
}