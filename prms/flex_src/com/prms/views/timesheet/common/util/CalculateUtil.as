package com.prms.views.timesheet.common.util
{
    import mx.formatters.NumberFormatter;

    public class CalculateUtil {
        public static function getElapsedTime(startTime:String, endTime:String):String {

            // Null チェック
            if (null == startTime || null == endTime) {
                return null;
            }

            // 「：」を削除する。
            var start:String = startTime.replace(":", "");
            var end:String = endTime.replace(":", "");

            // 長さチェック（４桁）
            if (start.length != 4 || end.length != 4) {
                return null;
            }

            var sHour:Number = new Number(start.substring(0, 2));
            var sMinute:Number = new Number(start.substring(2, 4));
            var sTotalMinute:Number = (sHour * 60) + sMinute;

            var eHour:Number = new Number(end.substring(0, 2));
            var eMinute:Number = new Number(end.substring(2, 4));
            var eTotalMinute:Number = (eHour * 60) + eMinute;

            var formatter:NumberFormatter = new NumberFormatter();
            formatter.precision = 2;

            return formatter.format((eTotalMinute - sTotalMinute) / 60);
        } // end getElapsedTime

        public static function getActualTime(startTime:String, endTime:String, lunchTime:String):String {

            // Null チェック
            if (null == startTime || null == endTime) {
                return null;
            }

            // 「：」を削除する。
            var start:String = startTime.replace(":", "");
            var end:String = endTime.replace(":", "");

            // 長さチェック（４桁）
            if (start.length != 4 || end.length != 4) {
                return null;
            }

            var sHour:Number = new Number(start.substring(0, 2));
            var sMinute:Number = new Number(start.substring(2, 4));
            var sTotalMinute:Number = (sHour * 60) + sMinute;

            var eHour:Number = new Number(end.substring(0, 2));
            var eMinute:Number = new Number(end.substring(2, 4));
            var eTotalMinute:Number = (eHour * 60) + eMinute;

            // lunchTimeが有効な値の場合のみ計算する
            if (lunchTime != null) {
                var lHour:Number = new Number(lunchTime.substring(0, 2));
                var lMinute:Number = new Number(lunchTime.substring(2, 4));
                var lTotalMinute:Number = (lHour * 60) + lMinute;
                eTotalMinute = eTotalMinute - lTotalMinute;
            }

            var formatter:NumberFormatter = new NumberFormatter();
            formatter.precision = 2;

            return formatter.format((eTotalMinute - sTotalMinute) / 60);
        } // end getActualTime

        public static function formatHHMM(elapsed:String):String {

            if (elapsed == null) {
                return null;
            }

            var nf:NumberFormatter = new NumberFormatter();
            nf.precision = 0;

            var temp:Array = elapsed.split('.');
            var fPartNumber:Number = new Number('0.' + temp[1]) * 60;
            var iPart:String = temp[0]; // 時
            var fPart:String = nf.format(fPartNumber.toFixed(0)); // 分

            // Zero Padding
            if (iPart.length == 1) {
                iPart = '0' + iPart;
            }
            if (fPart.length == 1) {
                fPart = '0' + fPart;
            }

            return iPart + fPart;
        } // end formatHHMM

    }
}

