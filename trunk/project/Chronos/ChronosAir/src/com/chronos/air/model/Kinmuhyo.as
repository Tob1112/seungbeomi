package com.chronos.air.model
{
	[Bindable]
	public class Kinmuhyo
	{
		public var nengetsu:String;				// 年月
		public var shinseiBango:String;			// 申請番号
		public var shinseiKubun:String;			// 申請区分
		public var shinseiJokyo:String;			// 申請状況
		public var syoteiNissu:Number;			// 所定日数
		public var sagyoNissu:Number;			// 作業日数
		public var kekkinNissu:Number;			// 欠勤日数
		public var jitsudoJikanGokei:Number;	// 実働時間合計
		public var sagyoGenba:String;			// 作業現場

		public static function createKinmuhyo():Kinmuhyo {
			var kinmuhyo:Kinmuhyo = new Kinmuhyo();
			kinmuhyo.nengetsu = "";
			kinmuhyo.shinseiBango = "";
			kinmuhyo.shinseiKubun = "";
			kinmuhyo.shinseiJokyo = "";
			kinmuhyo.syoteiNissu = 0;
			kinmuhyo.sagyoNissu = 0;
			kinmuhyo.kekkinNissu = 0;
			kinmuhyo.jitsudoJikanGokei = 0;
			kinmuhyo.sagyoGenba = "";

			return kinmuhyo;
		}
	}
}