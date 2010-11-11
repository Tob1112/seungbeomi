package com.chronos.air.model {

	[Bindable]
	public class ApplicationModel {

		public var shain:Shain = new Shain();

		private static var instance:ApplicationModel = null;

		public static function getInstance():ApplicationModel {
			if (instance == null) {
				instance = new ApplicationModel();
			}
			return instance;
		}
	}
}