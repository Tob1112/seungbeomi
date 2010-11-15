package com.chronos.air.model
{
	import flash.utils.Dictionary;

	[Bindable]
	public class ShinseiJokyoEnum
	{
		public static const SAKUSEITYU:ShinseiJokyoEnum			= new ShinseiJokyoEnum("1", "作成中");	// 作成中
		public static const UKETUKE_MACHI:ShinseiJokyoEnum		= new ShinseiJokyoEnum("2", "受付待ち");	// 受付待ち(CLIENT → APPENGINE)
		public static const KAKUNINTYU:ShinseiJokyoEnum			= new ShinseiJokyoEnum("3", "確認中");	// 確認中(APPENGINE → 管理者)
		public static const SHINSEI_KANRYO:ShinseiJokyoEnum		= new ShinseiJokyoEnum("4", "申請完了");	// 申請完了(申請登録完了)
		public static const TORISAGE:ShinseiJokyoEnum			= new ShinseiJokyoEnum("5", "取下");		// 取下(なんらかの問題で社員修正要)
		public static const TORISAGE_KAKUNINTYU:ShinseiJokyoEnum= new ShinseiJokyoEnum("6", "取下確認中");// 取下(なんらかの問題で社員修正要)

		private static var map:Dictionary = new Dictionary();
		private var code:String;
		private var value:String;

		public function ShinseiJokyoEnum(code:String, value:String) {
			this.code = code;
			this.value = value;
		}

		private static function get list():Dictionary {
			map[SAKUSEITYU.code] 			= SAKUSEITYU.value;
			map[UKETUKE_MACHI.code] 		= UKETUKE_MACHI.value;
			map[KAKUNINTYU.code] 			= KAKUNINTYU.value;
			map[SHINSEI_KANRYO.code] 		= SHINSEI_KANRYO.value;
			map[TORISAGE.code] 				= TORISAGE.value;
			map[TORISAGE_KAKUNINTYU.code]	= TORISAGE_KAKUNINTYU.value;
			return map;
		}

		public function toString():String {
			return this.code;
		}

		public function getValue():String {
			return this.value;
		}

		public static function fromCode(code:String):String {
			return list[code];
		}
	}
}