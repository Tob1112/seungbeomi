package com.prms.client.flex.views.timesheet.common
{
    import mx.formatters.DateFormatter;
    import mx.utils.StringUtil;

    public class LabelFormatter
    {

        /**
         * 時間Formatter
         * @param time 時間
         * @return XX:XXの形式
         */
        public function timeFormat(time:String):String
        {
            var formatVal:String = null;
            if(time == null || StringUtil.trim(time).length == 0){
                return "";
            }
            if(StringUtil.trim(time).length == 4){
                formatVal = time.substring(0,2) + ":" + time.substring(2,4);
            }else{
                formatVal = time;
            }
            return formatVal;
        }

        /**
         * Dateタイプのカラムを日付(曜日)の形式で返す。
         * @param date Date
         * @return 日付(曜日)の形式
         */
        public function formatDDEEE(date:Date):String {
            var dateFormatter:DateFormatter = new DateFormatter();
            dateFormatter.formatString = "DD(EEE)";
            return dateFormatter.format(date);
        }
    }
}

