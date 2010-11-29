package org.chronos.air.model
{
	import mx.collections.ArrayCollection;

	public class ShinkiKinmuhyo
	{
		public var nengetsu:String;			// 年月
		public var shigyoJikan:String;		// 始業時間
		public var shigyoJikanchi:Number;	// 始業時間値
		public var syuryoJikan:String;		// 終了時間
		public var syuryoJikanchi:Number;	// 終了時間値
		public var kyukeiJikan:Number;		// 休憩時間
		public var sagyoGenba:String;		// 作業現場
		public var setDefault:Boolean;		// Default値として反映

		private static var instance:ShinkiKinmuhyo = null;

		public static function getInstance():ShinkiKinmuhyo {
			if (instance == null) {
				instance = new ShinkiKinmuhyo();
				reset();
			}
			return instance;
		}

		public static function reset():void {
			instance.nengetsu = "";
			instance.shigyoJikan = "";
			instance.shigyoJikanchi = 0;
			instance.syuryoJikan = "";
			instance.syuryoJikanchi = 0;
			instance.kyukeiJikan = 0;
			instance.sagyoGenba = "";
			instance.setDefault = false;
		}


	}
}