package com.prms.util {

    /**
     *
     * @author developer002
     */
    public class CalendarUtil {
        /** 月の配列 */
        private var monthArray:Array = new Array(00, 01, 02, 03, 04, 05, 06, 07, 08, 09, 10, 11);
        /** LeapYear */
        private var domArray:Array = new Array(31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
        /** 曜日の配列 */
        private var dayOfWkArray:Array = new Array("日", "月", "火", "水", "木", "金", "土");
        /** 年 */
        public var year:String;
        /** 月 */
        public var month:Number;
        /** 月の最後の日 */
        public var lastDay:Number;


        /**
         *
         * @param yy 年
         * @param mm 月(0 = 1月 .... 11 = 12月)
         */
        public function CalendarUtil(yy:Number, mm:Number) {
            var daysInMonth:int = domArray[mm];
            if (isLeapYear(yy) && mm == 1) {
                daysInMonth++;
            }
            this.year = String(yy);
            this.month = monthArray[mm];
            this.lastDay = daysInMonth;
        }

        /**
         * 曜日を求める
         * @param dd 日付
         * @return 曜日(日、月、火、など)
         */
        public function dayOfWk(dd:Number):String {
            var date:Date = new Date(year, month, dd);
            return dayOfWkArray[date.day];
        }

        /**
         * LeapYearなのかをチェック
         * @param year 月
         * @return Boolean
         */
        private function isLeapYear(year:Number):Boolean {
            if (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0)) {
                return true;
            }
            return false;
        }
    }
}

