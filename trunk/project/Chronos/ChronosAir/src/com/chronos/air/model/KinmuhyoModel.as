package com.chronos.air.model {

	import mx.collections.ArrayCollection;

	[Bindable]
	public class KinmuhyoModel {

		public var currentDate:String;
		public var kinmuhyoAC:ArrayCollection = new ArrayCollection();
		public var shinseiAC:ArrayCollection = new ArrayCollection();

		private static var instance:KinmuhyoModel = null;

		public static function getInstance():KinmuhyoModel {
			if (instance == null) {
				instance = new KinmuhyoModel();
			}
			return instance;
		}

	}
}