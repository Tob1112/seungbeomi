package com.prms.views.timesheet.common.renderer
{
    import com.prms.Constants;
    import com.prms.model.TimesheetModelLocator;
    import com.prms.util.CalendarUtil;
    import com.prms.views.timesheet.common.util.CalculateUtil;
    import com.prms.vo.FixTime;
    import com.prms.vo.Timesheet;
    import com.prms.vo.TimesheetDetail;

    import flash.display.Sprite;
    import flash.events.MouseEvent;

    import mx.collections.ArrayCollection;
    import mx.controls.AdvancedDataGrid;
    import mx.controls.Alert;
    import mx.controls.Button;
    import mx.events.CloseEvent;

    public class FixTimeApplyBtnRenderer extends Button{
        [Bindable] public var model:TimesheetModelLocator = TimesheetModelLocator.getInstance();
        public function FixTimeApplyBtnRenderer()
        {
            super();
        }

        override public function initialize():void{
            super.initialize();
            this.label = "反映";
            // TODO width
        }

        override protected function clickHandler(event:MouseEvent):void{
            var msg:String = null;
            super.clickHandler(event);
            if(isNotNullTimesheetDetail(model.timesheetDetailAC)){
                msg = Constants.ALERT_MSG_FIXTIME_APPLY_BTN_NOTNULL_DATA;
            }else{
                msg = Constants.ALERT_MSG_FIXTIME_APPLY_BTN_NOT_DATA;
            }
            // TODO titleを修正、２番目のパラメータ
            Alert.show(msg,"",Alert.YES|Alert.CANCEL, Sprite(parent),buttonClickHandler);
        }

        private function buttonClickHandler(event:CloseEvent):void{
            if(event.detail == Alert.YES){
                initializeTimesheetValue();
            }
        }

        /**
         *	警告ウィンドーで「YES」が選択された場合の処理
         */
        private function initializeTimesheetValue():void{
            var selectedFixTime:FixTime = AdvancedDataGrid(this.owner).selectedItem as FixTime;
            var timesheet:Timesheet = model.timesheet;
            var cal:CalendarUtil = new CalendarUtil(timesheet.yyyymm.fullYear, timesheet.yyyymm.month);
            model.timesheetDetailAC = new ArrayCollection();
            model.timesheet.timesheetDetailList = new ArrayCollection();
            for(var day:Number = 1; day <= cal.lastDay; day++){
                model.timesheetDetailAC.addItem(createTimesheetDetail(timesheet, new Date(cal.year,cal.month, day), selectedFixTime));
            }
            model.timesheet.timesheetDetailList = model.timesheetDetailAC;
        }

        /**
         * 勤務表(日)
         * @param mmVO 勤務表(月)
         * @return 勤務表(日)Entity
         */
        private function createTimesheetDetail(timesheet:Timesheet, yyyymmdd:Date, fixTime:FixTime):TimesheetDetail{
            var vo:TimesheetDetail = new TimesheetDetail();
            // 会社コード
            vo.comCode = timesheet.comCode;
            // 社員番号
            vo.empNo = timesheet.empNo;
            // 年月
            vo.yyyymm = timesheet.yyyymm;
            // 年月日
            vo.yyyymmdd = yyyymmdd;
            // 勤務形態コード
            vo.workPatternCode = Constants.WORKPATTERN_CODE_HOLIDAY;
            // 「土曜日、日曜日」以外の場合
            if(yyyymmdd.day != 6 && yyyymmdd.day != 0){
                vo.workPatternCode = Constants.WORKPATTERN_CODE_NORMAL;
                // 定時名称
                vo.fixTimeName = fixTime.fixTimeName;
                // 始業時間
                vo.workStartTime = fixTime.workStartTime;
                // 終業時間
                vo.workEndTime = fixTime.workEndTime;
                // 昼休時間
                var lunchTime:String = CalculateUtil.getElapsedTime(fixTime.lunchStartTime, fixTime.lunchEndTime);
                vo.breakTimeTotal = CalculateUtil.formatHHMM(lunchTime);
                // 実動時間
                vo.actualTime = CalculateUtil.getActualTime(fixTime.workStartTime, fixTime.workEndTime, vo.breakTimeTotal);
            }
            return vo;
        }

        private function isNotNullTimesheetDetail(timesheetDetailAC:ArrayCollection):Boolean{
            var notNullFlg:Boolean = false;
            if(timesheetDetailAC != null){
                for each(var detail:TimesheetDetail in timesheetDetailAC){
                    if(detail.fixTimeName != null || detail.workPatternCode != null ||
                        detail.workStartTime != null || detail.workEndTime != null ||
                        detail.breakTimeTotal != null || detail.note != null){
                        notNullFlg = true;
                        break;
                    }
                }
            }
            return notNullFlg;
        }
    }
}

