package com.prms.client.flex.vo {

    [RemoteClass(alias="com.prms.client.server.model.TimesheetDetail")]
    [Bindable]
    /**
     * 勤務表 (日)
     * @author developer002
     *
     */
    public class TimesheetDetail {
        /** 会社コード */
        public var comCode:String;

        /** 社員番号 */
        public var empNo:String;

        /** 年月 */
        public var yyyymm:Date;

        /** 年月日 */
        public var yyyymmdd:Date;

        /** 勤務形態コード */
        public var workPatternCode:String;

        /** 定時名称 */
        public var fixTimeName:String;

        /** 始業時間 */
        public var workStartTime:String;

        /** 終業時間 */
        public var workEndTime:String;

        /** 勤務時間合計 */
        public var workTimeTotal:String;

        /** お休み時間 */
        public var lunchBreakTime:String;

        /** その他休憩時間 */
        public var etcBreakTime:String;

        /** 休憩時間合計 */
        public var breakTimeTotal:String;

        /** 実動時間 */
        public var actualTime:String;

        /** 超過勤務時間 */
        public var overWorkTime:String;

        /** 深夜勤務時間 */
        public var nightWorkTime:String;

        /** 休日勤務時間 */
        public var holidayWorkTime:String;

        /** 遅刻時間 */
        public var lateTime:String;

        /** 早退時間 */
        public var earlyTime:String;

        /** 備考 */
        public var note:String;

    }
}


