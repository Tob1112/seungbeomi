package com.prms.client.flex.views.timesheet.common.renderer
{
    import com.prms.client.flex.Constants;
    import com.prms.client.flex.model.TimesheetModelLocator;
    import com.prms.client.flex.views.timesheet.common.util.CalculateUtil;
    import com.prms.client.flex.vo.FixTime;
    import com.prms.client.flex.vo.TimesheetDetail;

    import flash.events.FocusEvent;

    import mx.collections.ArrayCollection;
    import mx.collections.IViewCursor;
    import mx.controls.AdvancedDataGrid;
    import mx.controls.ComboBox;

    public class FixTimeNameRenderer extends ComboBox
    {
        [Bindable]public var model:TimesheetModelLocator = TimesheetModelLocator.getInstance();
        public function FixTimeNameRenderer()
        {
            super();
        }

        override public function initialize():void{
            super.initialize();
            width = 120;
            height = 20;
            setStyle("openDuration", 50);
            setStyle("closeDuration", 50);
            setStyle("arrowButtonWidth", 0);
            labelField = "fixTimeName";
            dataProvider = getFixTimeNameAC();
        }

        override public function set data(value:Object):void{
            super.data = value;
            if (value != null){
                var currentValue:TimesheetDetail= value as TimesheetDetail;
                var len:int=dataProvider.length;
                for (var i:int=0; i < len; i++){
                    if (dataProvider[i].fixTimeName == currentValue.fixTimeName){
                        selectedIndex=i;
                        break;
                    }
                }
            }
        }

        override protected function focusInHandler(event:FocusEvent):void{
            super.focusInHandler(event);
            open();
        }

        override public function close(trigger:Event=null):void{
            super.close(trigger);
            // 勤務表のAdvancedDataGirdのデータ
            var selectedVO:TimesheetDetail = (owner as AdvancedDataGrid).selectedItem as TimesheetDetail;
            if(null != selectedItem){
                // 選択されたComboBoxのデータ
                var fixTimeVO:FixTime = selectedItem as  FixTime;
                var cursor:IViewCursor = model.timesheetDetailAC.createCursor();
                while(!cursor.afterLast){
                    var ddVO:TimesheetDetail = cursor.current as TimesheetDetail;
                    // 選択されたAdvancedDataGirdの年、月、日と、勤務表(日) ArrayCollectionの年、月、日が同じであれば、ComboBoxのデータで勤務表のデータを上書きする。
                    if((selectedVO.yyyymmdd.getFullYear() == ddVO.yyyymmdd.getFullYear()) &&
                        (selectedVO.yyyymmdd.getMonth() == ddVO.yyyymmdd.getMonth()) &&
                        (selectedVO.yyyymmdd.getDate() == ddVO.yyyymmdd.getDate())){
                        // 定時名称
                        ddVO.fixTimeName = fixTimeVO.fixTimeName;
                        // 始業時間
                        ddVO.workStartTime = fixTimeVO.workStartTime;
                        // 終業時間
                        ddVO.workEndTime = fixTimeVO.workEndTime;
                        // 昼休み時間処理
                        var ｌunchTime:String = CalculateUtil.getElapsedTime(fixTimeVO.lunchStartTime, fixTimeVO.lunchEndTime);
                        ddVO.breakTimeTotal = CalculateUtil.formatHHMM(ｌunchTime);
                        // 実動時間
                        ddVO.actualTime = CalculateUtil.getActualTime(fixTimeVO.workStartTime, fixTimeVO.workEndTime, ddVO.breakTimeTotal);
                        break;
                    }
                    cursor.moveNext();
                }
            }
        }

// TODO methodName 修正
        private function getFixTimeNameAC():ArrayCollection{
            model.fixTimeNameAC = new ArrayCollection();
            if(null != model.fixTimeNameDictionary){
                if(null != model.fixTimeNameDictionary[Constants.CONST_A]){
                    model.fixTimeNameAC.addItem(model.fixTimeNameDictionary[Constants.CONST_A]);
                }
                if(null != model.fixTimeNameDictionary[Constants.CONST_B]){
                    model.fixTimeNameAC.addItem(model.fixTimeNameDictionary[Constants.CONST_B]);
                }
                if(null != model.fixTimeNameDictionary[Constants.CONST_C]){
                    model.fixTimeNameAC.addItem(model.fixTimeNameDictionary[Constants.CONST_C]);
                }
            }
            return model.fixTimeNameAC;
        }
    }
}

