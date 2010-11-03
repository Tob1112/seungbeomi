package com.chronos.air.sample
{
	import flash.net.FileReference;

	[Bindable]
	public class PersonModelLocator
	{
		public var person:Person;
		public var result:String;

		public var fileUpDownLoad:FileUpDownLoad;
		public var uploadFiles:Array = new Array();

		private static var instance:PersonModelLocator = null;

		public static function getInstance():PersonModelLocator {
			if (instance == null) {
				instance = new PersonModelLocator();
			}
			return instance;
		}
	}
}