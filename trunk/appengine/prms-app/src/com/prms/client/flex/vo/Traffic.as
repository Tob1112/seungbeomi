package com.prms.client.flex.vo
{
	import mx.collections.ArrayCollection;

	[RemoteClass(alias="com.prms.client.server.model.Traffic")]
	/**
	 * 交通費（月合計）
	 */
	[Bindable]
	public class Traffic{
		/** 会社コード */
		public var comCode:String;

		/** 社員番号 */
		public var empNo:String;

		/** 年月 */
		public var yyyymm:Date;

		/** ステータスコード */
		public var statusCode:String;

		/** ステータスコードネーム */
		public var codeDetailName:String;

		/** 定期券合計 */
		public var trainTotal:Number;

		/** バス代合計 */
		public var busTotal:Number;

		/** その他合計 */
		public var otherTotal:Number;

		/** 定期合計 */
		public var regularTotal:Number;

		/** 非定期 - 通勤分合計 */
		public var commutationTotal:Number;

		/** 業務分交通費合計 */
		public var affairsTrafficTotal:Number;

		/** 業務分出張費合計 */
		public var affairsTravelTotal:Number;

		/** 交通費合計 */
		public var trafficTotal:Number;

		/** 更新者ID */
		public var updateId:String;

		/** 更新日 */
		public var updateDate:Date;

		/** 定期 - 定期券 */
		public var regTrain:ArrayCollection;

		/** 現在日付*/
		public var currentDate:Date;
	}
}