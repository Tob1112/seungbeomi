package com.prms.vo
{
	[RemoteClass(alias="com.prms.model.TrafficIrregular")]
	[Bindable]
	public class TrafficIrregular{
		/** 会社コード */
		public var comCode:String;

		/** 社員番号 */
		public var empNo:String;

		/** 出発地 */
		public var departurePoint:String;

		/** 到着地 */
		public var arrivalPoint:String;

		/** 年月 */
		public var yyyymm:Date;

		/** 年月日 */
		public var yyyymmdd:Date;

		/** 電車代 */
		public var trainFare:Number;

		/** バス代 */
		public var busFare:Number;

		/** その他 */
		public var otherFare:Number;

		/** 備考 */
		public var note:String;

		/** タクシー代 */
		public var taxiFare:Number;

		/** 宿泊費 */
		public var hotelFare:Number;

		/** 区分（01:通勤分, 02:業務分） */
		public var division:String;

		/** 更新者ID */
		public var updateId:String;

		/** 更新日 */
		public var updateDate:Date;


	}
}