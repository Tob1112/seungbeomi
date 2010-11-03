package com.chronos.air.model {

	[Bindable]
	public class KinmuhyoModelLocator {

		public var currentDate:String;

		private static var instance:KinmuhyoModelLocator = null;

		public static function getInstance():KinmuhyoModelLocator {
			if (instance == null) {
				instance = new KinmuhyoModelLocator();
			}
			return instance;
		}

	}
}