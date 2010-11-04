package com.chronos.air.model {

	[Bindable]
	public class MainModel {

		public var user:User = new User();

		private static var instance:MainModel = null;

		public static function getInstance():MainModel {
			if (instance == null) {
				instance = new MainModel();
			}
			return instance;
		}
	}
}