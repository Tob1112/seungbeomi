package com.chronos.air.model {

	[Bindable]
	public class MainModelLocator {

		public var user:User = new User();

		private static var instance:MainModelLocator = null;

		public static function getInstance():MainModelLocator {
			if (instance == null) {
				instance = new MainModelLocator();
			}
			return instance;
		}
	}
}