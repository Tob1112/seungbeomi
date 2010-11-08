package com.chronos.air.model {

	import mx.collections.ArrayCollection;

	[Bindable]
	public class KinmuhyoModel {

		public var currentDate:String;	// 現在日時
		public var kinmuhyo:Kinmuhyo = new Kinmuhyo();	// 勤務表
		public var kinmuhyoAC:ArrayCollection = new ArrayCollection();	// 勤務表リスト
		public var kinmuhyoShosaiAC:ArrayCollection = new ArrayCollection();	// 勤務表詳細
		public var shinkiKinmuhyo:ShinkiKinmuhyo;	// 新規勤務表

		private static var instance:KinmuhyoModel = null;

		public static function getInstance():KinmuhyoModel {
			if (instance == null) {
				instance = new KinmuhyoModel();
			}
			return instance;
		}

	}
}