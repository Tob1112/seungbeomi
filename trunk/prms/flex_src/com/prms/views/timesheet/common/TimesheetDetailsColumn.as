package com.prms.views.timesheet.common
{
    import com.prms.views.timesheet.common.renderer.ColumnColorRenderer;
    import com.prms.views.timesheet.common.renderer.ColumnEditableRenderer;
    import com.prms.views.timesheet.common.renderer.FixTimeApplyBtnRenderer;
    import com.prms.views.timesheet.common.renderer.FixTimeNameRenderer;
    import com.prms.views.timesheet.common.renderer.WorkPatternCodeRenderer;

    import mx.controls.advancedDataGridClasses.AdvancedDataGridColumn;
    import mx.core.ClassFactory;

    public class TimesheetDetailsColumn extends AdvancedDataGridColumn
    {
        private var _type:String = "";


        public function TimesheetDetailsColumn(columnName:String = null)
        {
            super(columnName);
            setStyle("textAlign", "center");
        }

        [Inspectable(defaultValue="time", enumeration="date,time,workType,fixTime,fixApplyButton,unitTime,default")]
        public function set format(type:String):void
        {
            _type = type;
            var editFactory:ClassFactory = new ClassFactory(ColumnEditableRenderer);
            if(type != "fixApplyButton"){
                var colorFactory:ClassFactory = new ClassFactory(ColumnColorRenderer);
            }

            switch(type){
                case "date":// 日付
                    labelFunction = new LabelFunction().dayFormat;
                    colorFactory.properties = {fontColorFlg:true};
                    itemRenderer = colorFactory;
                    break;
                case "time":// 時間
                    labelFunction = new LabelFunction().timeFormat;
                    editFactory.properties = {maxCh:4}
                    itemEditor = editFactory;
                    itemRenderer = colorFactory;
                    break;
                case "workType":// 勤務形態
                    labelFunction = new LabelFunction().workPatternCode;
                    itemEditor = new ClassFactory(WorkPatternCodeRenderer);
                    itemRenderer = colorFactory;
                    break;
                case "fixTime":// 定時情報名称
                    itemEditor = new ClassFactory(FixTimeNameRenderer);
                    itemRenderer = colorFactory;
                    break;
                case "fixApplyButton":// 反映ボタン
                    itemRenderer = new ClassFactory(FixTimeApplyBtnRenderer);
                    break;
                case "unitTime": // 時間単位
                    editFactory.properties = {maxCh:2,dataField:'timeUnit'}
                    itemEditor = editFactory;
                    itemRenderer = colorFactory;
                    break;
                default:
                    itemRenderer = colorFactory;
                    break;
            }
        }
    }
}

