package com.chronos.air.model
{
	[Bindable]
	public class KinmuhyoShosai
	{
		public var nengetsu:String;			// 年月
		public var hizuke :String;			// 日付
		public var yasumiKubun:String;		// 休み区分
		public var shigyoJikan:String;		// 始業時間
		public var shigyoJikanchi:Number;	// 始業時間
		public var syuryoJikan:String;		// 終了時間
		public var syuryoJikanchi:Number;	// 終了時間
		public var kyukeiJikan:Number;		// 休憩時間
		public var jitsudoJikan:Number;		// 実働時間
		public var sagyoNaiyo:String;		// 作業内容

	}
}