package org.chronos.air.sample
{
	import flash.utils.ByteArray;

	[RemoteClass(alias="org.chronos.appengine.sample.FileUpDownLoad")]
	[Bindable]
	public class FileUpDownLoad
	{
		public var name:String;
		public var data:ByteArray;
	}
}