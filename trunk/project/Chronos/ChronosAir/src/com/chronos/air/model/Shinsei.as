package com.chronos.air.model {

	import flash.utils.ByteArray;

	//[RemoteClass(alias="com.chronos.domain.Shinsei")]
	//[RemoteClass(alias="com.chronos.appengine.sample.Shinsei")]
	[RemoteClass(alias="com.chronos.domain.Shinsei")]
	[Bindable]
	public class Shinsei {
		// TODO 勤務表・交通費など対応するように
		public var shain:Shain;								// 社員
		public var kinmuhyo:Kinmuhyo;						// 申請書
		public var shinseiFileName:String;					// 申請ファイル名
		public var shinseiData:ByteArray;	// 申請データ
	}
}