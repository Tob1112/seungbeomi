package com.chronos.air.model {

	[Bindable]
	public class KinmuhyoModel {

		public var currentDate:String;

		private static var instance:KinmuhyoModel = null;

		public static function getInstance():KinmuhyoModel {
			if (instance == null) {
				instance = new KinmuhyoModel();
			}
			return instance;
		}

	}
}