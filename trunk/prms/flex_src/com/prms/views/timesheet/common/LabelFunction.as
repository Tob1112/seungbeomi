package com.prms.views.timesheet.common
{
    import com.prms.model.TimesheetModelLocator;
    import com.prms.util.fommater.LabelDateFormatter;
    import com.prms.vo.CodeDetail;

    import mx.collections.ArrayCollection;
    import mx.collections.IViewCursor;
    import mx.controls.advancedDataGridClasses.AdvancedDataGridColumn;

    public class LabelFunction
    {
        [Bindable]public var model:TimesheetModelLocator = TimesheetModelLocator.getInstance();

        /**
         * 日付フォーマット
         * @param item Object
         * @param column AdvancedDataGridColumn
         * @return 日(曜日)形式 例)01(月)
         */
        public function dayFormat(item:Object, column:AdvancedDataGridColumn):String
        {
            var formatValue:String = "";
            if(item[column.dataField] == null) return "";
            if(item[column.dataField] is Date){
                formatValue = new LabelFormatter().formatDDEEE(item[column.dataField]);
            }else{
                formatValue = String(item[column.dataField]);
            }
            return formatValue;
        }

        /**
         * 時間フォーマット
         * @param item Object
         * @param column AdvancedDataGridColumn
         * @return (時：分)形式 例)09：00
         */
        public function timeFormat(item:Object, column:AdvancedDataGridColumn):String
        {
            if(item[column.dataField] == null) return "";
            return new LabelFormatter().timeFormat(item[column.dataField]);
        }

        /**
         * 勤務形態コードをコード名にフォー マットする
         * @param item Object
         * @param column AdvancedDataGridColumn
         * @return コード名 例)通常勤務
         */
        public function workPatternCode(item:Object, column:AdvancedDataGridColumn):String
        {
            var returnValue:String = "";
            var codeDetailAC:ArrayCollection = model.codeDetailAC;
            var cursor:IViewCursor = codeDetailAC.createCursor();
            while (!cursor.afterLast) {
                var codeDetail:CodeDetail = cursor.current as CodeDetail;
                if (item.workPatternCode == codeDetail.codeDetail) {
                    returnValue = codeDetail.codeDetailName;
                    break;
                }
                cursor.moveNext();
            }
            return returnValue;
        }
    }
}

