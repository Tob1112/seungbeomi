package com.prms.client.flex.views.timesheet.common.util
{
    import com.prms.client.flex.Constants;
    import com.prms.client.flex.vo.FixTime;
    import com.prms.client.flex.vo.TimesheetDetail;

    import mx.utils.StringUtil;

    public class ValidationUtil
    {
        public static function validationCheck(obj:Object):Boolean{
            if(isNullOfObject(obj)){
                return true;
            }
            // 1. required check
            if(!requiredCheck(obj)){
                return false;
            }
            // 2. sizeCheck
            if(!sizeCheck(obj)){
                return false;
            }
            // 3. pair check
            if(!pairCheckOfObject(obj)){
                return false;
            }
            // 4. startEndTime check
            if(!startEndTimeCheckOfObject(obj)){
                return false;
            }
            return true;
        }


        // OK-true NG-false
        private static function requiredCheck(obj:Object):Boolean{
            if(obj is FixTime){
                var fixTime:FixTime = obj as FixTime;
                // 必須項目：名称、顧客名、時間単位、定時開始、定時終了
                if(isEmpty(fixTime.fixTimeName) || isEmpty(fixTime.clientName) ||
                    isEmpty(fixTime.timeUnit) || isEmpty(fixTime.workStartTime) || isEmpty(fixTime.workEndTime)){
                    return false;
                }
            }else if(obj is TimesheetDetail){
                var detail:TimesheetDetail = obj as TimesheetDetail;
                // 必須項目：勤務形態、定時情報名称、開始、終了、休憩、実動時間
                if(isEmpty(detail.workPatternCode) || isEmpty(detail.fixTimeName) || isEmpty(detail.workStartTime) ||
                    isEmpty(detail.workEndTime) || isEmpty(detail.breakTimeTotal) || isEmpty(detail.actualTime)){
                    return false;
                }
            }
            return true;
        }

        // OK-true NG-false
        private static function sizeCheck(obj:Object):Boolean{
            if(obj is FixTime){
                var fixTime:FixTime = obj as FixTime;
                // 時間単位、定時開始、定時終了、昼休開始、昼休開始
                if(!isEmpty(fixTime.timeUnit) && removeColon(fixTime.timeUnit).length != 2){
                    return false;
                }
                if(!isEmpty(fixTime.workStartTime) && removeColon(fixTime.workStartTime).length != 4){
                    return false;
                }
                if(!isEmpty(fixTime.workEndTime) && removeColon(fixTime.workEndTime).length != 4){
                    return false;
                }
                if(!isEmpty(fixTime.lunchStartTime) && removeColon(fixTime.lunchStartTime).length != 4){
                    return false;
                }
                if(!isEmpty(fixTime.lunchEndTime) && removeColon(fixTime.lunchEndTime).length != 4){
                    return false;
                }
            }else if(obj is TimesheetDetail){
                // 開始、終了、休憩
                var detail:TimesheetDetail = obj as TimesheetDetail;
                if(!isEmpty(detail.workStartTime) && removeColon(detail.workStartTime).length != 4){
                    return false;
                }
                if(!isEmpty(detail.workEndTime) && removeColon(detail.workEndTime).length != 4){
                    return false;
                }
                if(!isEmpty(detail.breakTimeTotal) && removeColon(detail.breakTimeTotal).length != 4){
                    return false;
                }
            }
            return true;
        }

        // OK-true NG-false
        private static function startEndTimeCheckOfObject(obj:Object):Boolean{
            if(obj is FixTime){
                var fixTime:FixTime = obj as FixTime;
                // 定時時間
                if(!startEndTimeCheck(fixTime.workStartTime, fixTime.workEndTime)){
                    return false;
                }
                // 昼休時間
                if(!startEndTimeCheck(fixTime.lunchStartTime, fixTime.lunchEndTime)){
                    return false;
                }
            }else if(obj is TimesheetDetail){
                var detail:TimesheetDetail = obj as TimesheetDetail;
                if(!startEndTimeCheck(detail.workStartTime, detail.workEndTime)){
                    return false;
                }
            }
            return true;
        }

        // OK-true NG-false
        private static function pairCheckOfObject(obj:Object):Boolean{
            if(obj is FixTime){
                var fixTime:FixTime = obj as FixTime;
                if(!pairCheck(fixTime.lunchStartTime, fixTime.lunchEndTime)){
                    return false;
                }
            }else if(obj is TimesheetDetail){// TODO これ必要？ Detailはほとんど必須なので、必須チェックとstart>end だけで大丈夫かも、
                var detail:TimesheetDetail = obj as TimesheetDetail;
            }
            return true;
        }

        // OK-true NG-false
        private static function startEndTimeCheck(start:String, end:String):Boolean{
            if(isEmpty(start) && isEmpty(end)){
                return true;
            }else if(!isEmpty(start) && !isEmpty(end)){
                if(Number(removeColon(start)) < Number(removeColon(end))){
                    return true;
                }
            }
            return false;
        }

        /*
         * OK - true NG - false
         * start end 両方が全部ヌル 又 全部ヌルではない場合：OK
         * それ以外はNGとする。
         */
        private static function pairCheck(start:String, end:String):Boolean{
            // 「start,end」両方がnullの場合
            if(isEmpty(start) && isEmpty(end)){
                return true;
            }// start,end」両方がnullではないの場合
            else if(!isEmpty(start) && !isEmpty(end)){
                return true;
            }
            return false;
        }// end pairCheck

        // OK-true NG-false
        public static function isNullOfObject(obj:Object):Boolean {
            if(obj == null){
                return true;
            }
            if(obj is FixTime){
                var fixTime:FixTime = obj as FixTime;
                // fixTimeNameは？？ 今は自動的にA,B,Cで採番されるが、後の変更結果によって修正しないと...
                if (isEmpty(fixTime.clientName) && isEmpty(fixTime.timeUnit) &&
                    isEmpty(fixTime.workStartTime) && isEmpty(fixTime.workEndTime) && isEmpty(fixTime.lunchStartTime) && isEmpty(fixTime.lunchEndTime)) {
                    return true;
                }
            }else if(obj is TimesheetDetail){
                var detail:TimesheetDetail = obj as TimesheetDetail;
                if(detail.workPatternCode == Constants.WORKPATTERN_CODE_HOLIDAY){
                    if(isEmpty(detail.fixTimeName) && isEmpty(detail.workStartTime) && isEmpty(detail.workEndTime) &&
                        isEmpty(detail.breakTimeTotal) && isEmpty(detail.actualTime)){
                        return true;
                    }
                }else{
                    if(isEmpty(detail.workPatternCode) && isEmpty(detail.fixTimeName) && isEmpty(detail.workStartTime) &&
                        isEmpty(detail.workEndTime) && isEmpty(detail.breakTimeTotal) && isEmpty(detail.actualTime)){
                        return true;
                    }
                }
            }
            return false;
        }

        // OK-true NG-false
        public static function isEmpty(obj:Object):Boolean {
            var flg:Boolean = false; // フラグ
            if (obj == null) {
                return true;
            }
            if (obj is String) { // String type
                var strObj:String = obj as String;
                if (strObj == null) {
                    flg = true;
                }else {
                    var trimStr:String = StringUtil.trim(strObj);
                    if (trimStr == "" || trimStr.length == 0) {
                        flg = true;
                    }
                }
            }else if (obj is Date) { // Date type
                if (obj == null) {
                    flg = true;
                }
            }
            return flg;
        }

        // TODO このメソッドってここにいって大丈夫??
        public static function removeColon(str:String):String{
            if (isEmpty(str)) {
                return null;
            }
            return str.replace(":", "");
        }

        public static function removeBlank(str:String):String{
            if(str == null){
                return null;
            }
            return str.replace(" ", "");
        }
    }
}

