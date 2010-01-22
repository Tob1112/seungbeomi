package com.prms.vo
{
	import mx.collections.ArrayCollection;
	import mx.formatters.DateFormatter;

	[Bindable]
	public class TrafficRegular{
		/** 会社コード */
		public var comCode:String;

		/** 社員番号 */
		public var empNo:String;

		/** 年月 */
		public var yyyymm:Date;

		/** 出発地 */
		public var departurePoint:String;

		/** 到着地 */
		public var arrivalPoint:String;

		/** 開始日 */
		public var startDate:Date;

		/** 終了日 */
		public var endDate:Date;

		/** 金額 */
		public var fare:Number;

		/** 備考 */
		public var note:String;

		/** 片道金額（定価） */
		public var oneWayFixedFare:Number;

		/** 片道金額（バスカード利用金額） */
		public var oneWayDcFare:Number;

		/** 更新者ID */
		public var updateId:String;

		/** 更新日 */
		public var updateDate:Date;



		public var seq:int;

		/** 交通費定期 - 定期券 */
		public var regTrainAC:ArrayCollection;



		public var section:String;
		public var period:String;

		public var startDateTypeString:String;
		public var endDateTypeString:String;
		private var dateFormatter:DateFormatter = new DateFormatter();

		public function setStartDate(startDate:Date):void{
			dateFormatter.formatString = "YYYY/MM/DD";
			this.startDateTypeString = dateFormatter.format(startDate);
//			this.startDate = startDate;
			setPeriod();
		}

		public function setEndDate(endDate:Date):void{
			dateFormatter.formatString = "YYYY/MM/DD";
			this.endDateTypeString = dateFormatter.format(endDate);
//			this.endDate = endDate;
			setPeriod();
		}

		public function setPeriod():void{

//			this.period = dateFormatter.format(this.startDate) + dateFormatter.format(this.endDate);
			this.period = this.startDateTypeString + this.endDateTypeString;
		}

		public function setDeparturePoint(departurePoint:String):void{
			this.departurePoint = departurePoint;
			setSection();
		}

		public function setArrivalPoint(arrivalPoint:String):void{
			this.arrivalPoint = arrivalPoint;
			setSection();
		}

		public function setSection():void{
			this.section = this.departurePoint + this.arrivalPoint;
		}
	}
}