package com.prms.views.timesheet.common.renderer
{
    import com.prms.views.timesheet.common.util.ValidationUtil;
    import com.prms.vo.FixTime;
    import com.prms.vo.TimesheetDetail;

    import flash.events.FocusEvent;

    import mx.controls.TextInput;

    public class ColumnEditableRenderer extends TextInput
    {
        public var maxCh:int = 0;
        public var dataField:String = "";

        public function ColumnEditableRenderer()
        {
            super();
        }

        override public function set data(value:Object):void{
            super.data = value;
            // if (value != null){
            //  value = removeBlank(value);
            // }
            setRestrict();
        }// end set data


        private function setRestrict():void{
            restrict = "0-9";
            if(maxCh > 0){
                maxChars = maxCh;
            }
        }

        override protected function focusInHandler(event:FocusEvent):void{
            super.focusInHandler( event );
            if(data != null && dataField != null){
                var tmp:String = "";
                switch(dataField){
                    case "timeUnit":
                        tmp = ValidationUtil.removeBlank(FixTime(data).timeUnit);
                        textField.text = tmp;
                        break;
                }
            }
        }// end focusIn



    /* private function removeBlank(value:Object):Object{
       var returnVal:Object = null;
       if(value is FixTime){
       var fixTime:FixTime = value as FixTime;
       fixTime.timeUnit = ValidationUtil.removeBlank(fixTime.timeUnit);// 時間単位
       fixTime.workStartTime = ValidationUtil.removeBlank(fixTime.workStartTime);// 定時開始
       fixTime.workEndTime = ValidationUtil.removeBlank(fixTime.workEndTime);// 定時終了
       fixTime.lunchStartTime = ValidationUtil.removeBlank(fixTime.lunchStartTime);// 昼休開始
       fixTime.lunchEndTime = ValidationUtil.removeBlank(fixTime.lunchEndTime);// 昼休終了
       returnVal = fixTime;
       }else if(value is TimesheetDetail){
       var detail:TimesheetDetail = value as TimesheetDetail;
       detail.workStartTime = ValidationUtil.removeBlank(detail.workStartTime);// 定時開始
       detail.workEndTime = ValidationUtil.removeBlank(detail.workEndTime);// 定時終了
       detail.breakTimeTotal = ValidationUtil.removeBlank(detail.breakTimeTotal);// 時間単位
       returnVal = detail;
       }
       return returnVal;
     }*/// end removeBlank
    }
}


