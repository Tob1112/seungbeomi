package com.prms.client.flex.vo {
    import mx.collections.ArrayCollection;

    [RemoteClass(alias="com.prms.client.server.model.Timesheet")]
    [Bindable]
    /**
     * 勤務表（月）
     * @author developer002
     */
    public class Timesheet {
        /** 会社コード */
        public var comCode:String;

        /** 社員番号 */
        public var empNo:String;

        /** 年月 */
        public var yyyymm:Date;

        /** 確定フラグ */
        public var fixFlag:String;

        /** ステータスコード */
        public var statusCode:String;

        /** 実働時間合計 */
        public var actualTimeTotal:String;

        /** 休憩時間合計 */
        public var breakTimeTotal:String;

        /** 超過勤務時間合計 */
        public var overTimeTotal:String;

        /** 深夜勤務時間合計 */
        public var nightTimeTotal:String;

        /** 休日出勤時間合計 */
        public var holidayTimeTotal:String;

        /** 遅刻時間合計 */
        public var lateTimeTotal:String;

        /** 早退時間合計 */
        public var earlyTimeTotal:String;

        /** 当月有休消合計 */
        public var thisMonthPvTotal:String;

        /** 欠勤日数合計 */
        public var absenceDaysTotal:String;

        /** 勤務表 (日) */
        public var timesheetDetailList:ArrayCollection;

        /** 定時情報 */
        public var fixTimeList:ArrayCollection;

        /** 年 */
        public var yyyy:Number;

        /** 月 */
        public var mm:Number;

        /** 勤務表一覧番号 */
        public var listSeq:int;

        /** 勤務表コードネーム */
        public var codeDetailName:String;

        /** 社員名（姓） */
        public var lastName:String;

        /** 社員名（名） */
        public var firstName:String;

        /** 現在の日付 */
        public var currentDate:Date;

        /** 現在の日付（画面） */
        public var currentDateTypeIsString:String;

        /** 社員名 */
        public var empName:String;

        public function get name():String {
        	return this.lastName + " " + firstName;
        }

        public function get displayYYYYMM():String {
        	return this.yyyymm.getFullYear() + "年" + (this.yyyymm.getMonth() + 1) + "月";
        }

    }
}

