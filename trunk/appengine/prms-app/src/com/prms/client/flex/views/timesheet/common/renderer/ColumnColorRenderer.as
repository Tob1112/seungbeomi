package com.prms.client.flex.views.timesheet.common.renderer
{
    import com.prms.client.flex.model.TimesheetModelLocator;
    import com.prms.client.flex.views.timesheet.common.util.ValidationUtil;
    import com.prms.client.flex.vo.FixTime;
    import com.prms.client.flex.vo.TimesheetDetail;

    import flash.display.Graphics;

    import mx.controls.Label;
    import mx.core.IFactory;

    public class ColumnColorRenderer extends Label implements IFactory
    {
        private var num:int = 0;
        private var errorFlg:Boolean = false;
        public var fontColorFlg:Boolean = false;

        [Bindable]public var model:TimesheetModelLocator = TimesheetModelLocator.getInstance();

        public function newInstance():*{
            return new ColumnColorRenderer();
        }

        public function ColumnColorRenderer()
        {
            super();
        }

        override public function set data(value:Object):void
        {
            super.data = value;
            if(value != null){
                errorFlg = isError();
                if(value is FixTime){
                    addFixTimeName(FixTime(value), errorFlg);
                }else if(value is TimesheetDetail){
                    var detail:TimesheetDetail = value as TimesheetDetail;
                    changeDateFontColor(detail.yyyymmdd, fontColorFlg);
                }
            }
        }// end set data

        override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
        {
            super.updateDisplayList(unscaledWidth,unscaledHeight);
            var g:Graphics = graphics;
            var color:uint = 0xFFFFFF;
            alpha = 0.0;
            if(errorFlg){
                color = 0xCE9595;
                alpha = 1;
            }
            g.clear();
            g.beginFill(color, 1);
            g.drawRect(0, -2, unscaledWidth, unscaledHeight + 4);
            g.endFill();
        }// end updateDisplayList


        private function changeDateFontColor(date:Date, fontColorFlg:Boolean):void
        {
            if(!fontColorFlg){
                return;
            }
            switch(date.day)
            {
                case 0:
                    setStyle("color", 0xFF0000);
                    break;
                case 6:
                    setStyle("color", 0x0000FF);
                    break;
                default:
                    setStyle("color", 0x000000);
                    break;
            }
        }// end changeDateFontColor

        private function addFixTimeName(fixTime:FixTime, errorFlg:Boolean):void{
            if(ValidationUtil.isNullOfObject(fixTime)){
                return;
            }
            if(errorFlg){
                model.fixTimeNameDictionary[fixTime.fixTimeName] = null;
            }else{
                model.fixTimeNameDictionary[fixTime.fixTimeName] = createFixTime(fixTime);
            }
        }// end addFixTimeName

        // error -> true
        private function isError():Boolean{
            if(!ValidationUtil.validationCheck(data)){
                return true;
            }
            return false;
        }

        private function createFixTime(vo:FixTime):FixTime {
            var fixTimeVO:FixTime = new FixTime();
            fixTimeVO.comCode = vo.comCode; // 会社コード
            fixTimeVO.empNo = vo.empNo; // 社員番号
            fixTimeVO.yyyymm = vo.yyyymm; // 年月
            fixTimeVO.fixTimeName = vo.fixTimeName; // 定時名称
            fixTimeVO.clientName = vo.clientName; // 顧客名
            fixTimeVO.timeUnit = vo.timeUnit; // 時間単位
            fixTimeVO.workStartTime = vo.workStartTime; // 定時開始
            fixTimeVO.workEndTime = vo.workEndTime; // 定時終了
            fixTimeVO.lunchStartTime = vo.lunchStartTime; // 昼休開始
            fixTimeVO.lunchEndTime = vo.lunchEndTime; // 昼休終了
            return fixTimeVO;
        }// end createFixTime
    }
}

