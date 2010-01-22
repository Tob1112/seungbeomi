package com.prms.vo {

    /**
     * 定時情報
     * @author developer002
     */
    [RemoteClass(alias="com.prms.model.FixTime")]
    [Bindable]
    public class FixTime {
        /** 会社コード */
        public var comCode:String;

        /** 社員番号 */
        public var empNo:String;

        /** 年月 */
        public var yyyymm:Date;

        /** 定時名称 */
        public var fixTimeName:String;

        /** 顧客名 */
        public var clientName:String;

        /** 時間単位 */
        public var timeUnit:String;

        /** 始業時間 */
        public var workStartTime:String;

        /** 終業時間 */
        public var workEndTime:String;

        /** お昼休み開始時間 */
        public var lunchStartTime:String;

        /** お昼休み終了時間 */
        public var lunchEndTime:String;

    }
}

