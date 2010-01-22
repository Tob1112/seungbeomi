package com.prms.views.timesheet.common.renderer
{
    import com.prms.Constants;
    import com.prms.model.TimesheetModelLocator;
    import com.prms.vo.TimesheetDetail;

    import flash.events.FocusEvent;

    import mx.collections.IViewCursor;
    import mx.controls.AdvancedDataGrid;
    import mx.controls.ComboBox;

    public class WorkPatternCodeRenderer extends ComboBox{
        [Bindable]public var model:TimesheetModelLocator = TimesheetModelLocator.getInstance();

        public function WorkPatternCodeRenderer()
        {
            super();
        }

        override public function initialize():void{
            super.initialize();
            labelField = "codeDetailName";
            setStyle("arrowButtonWidth", 0);
            dataProvider = model.codeDetailAC;
        }

        override protected function focusInHandler(event:FocusEvent):void{
            super.focusInHandler(event);
            open();
        }

        override public function set data(value:Object):void{
            super.data = value;
            if (value != null){
                for (var i:int=0, f:int=dataProvider.length; i < f; i++) {
                    if (dataProvider[i].codeDetail == data.workPatternCode) {
                        selectedIndex = i;
                        break;
                    }
                }
            }
        }

        override public function close(trigger:Event=null):void{
            super.close(trigger);
            var selectedVO:TimesheetDetail = (owner as AdvancedDataGrid).selectedItem as TimesheetDetail;
            if(selectedItem != null){
                if (selectedVO.workPatternCode != null && selectedItem.codeDetail != null) {
                    selectedVO.workPatternCode = selectedItem.codeDetail;
                    // 勤務形態が公休の場合
                    if(selectedVO.workPatternCode == Constants.WORKPATTERN_CODE_HOLIDAY){
                        var cursor:IViewCursor = model.timesheetDetailAC.createCursor();
                        while(!cursor.afterLast){
                            var ddVO:TimesheetDetail = cursor.current as TimesheetDetail;
                            // 選択されたAdvancedDataGirdの年、月、日と、勤務表(日) ArrayCollectionの年、月、日が同じであれば、ComboBoxのデータで勤務表のデータを上書きする。
                            if((selectedVO.yyyymmdd.getFullYear() == ddVO.yyyymmdd.getFullYear()) &&
                                (selectedVO.yyyymmdd.getMonth() == ddVO.yyyymmdd.getMonth()) &&
                                (selectedVO.yyyymmdd.getDate() == ddVO.yyyymmdd.getDate())){
                                // 定時名称
                                ddVO.fixTimeName = null;
                                // 始業時間
                                ddVO.workStartTime = null;
                                // 終業時間
                                ddVO.workEndTime = null;
                                // 昼休み時間処理
                                ddVO.breakTimeTotal = null;
                                // 実動時間
                                ddVO.actualTime = null;
                                break;
                            }
                            cursor.moveNext();
                        }
                    }
                }
            }
        }
    }
}

