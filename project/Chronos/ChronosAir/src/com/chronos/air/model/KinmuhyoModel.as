package com.chronos.air.model {

	import mx.collections.ArrayCollection;

	[Bindable]
	public class KinmuhyoModel {

		public var currentDate:String;
		public var kinmuhyo:Kinmuhyo = new Kinmuhyo();
		public var kinmuhyoAC:ArrayCollection = new ArrayCollection();
		public var kinmuhyoShosaiAC:ArrayCollection = new ArrayCollection();

		private static var instance:KinmuhyoModel = null;

		public static function getInstance():KinmuhyoModel {
			if (instance == null) {
				instance = new KinmuhyoModel();
			}
			return instance;
		}

	}
}