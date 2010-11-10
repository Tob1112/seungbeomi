package com.chronos.air.util {

    import mx.controls.dataGridClasses.DataGridColumn;
    import mx.formatters.DateFormatter;

    public class DateColumnFormatter {
        private var dateFormatter:DateFormatter;

        public function DateColumnFormatter() {
            dateFormatter=new DateFormatter();
            dateFormatter.formatString="MM/DD(EEE)";
        }

        public function format(item:Object, column:DataGridColumn):String {
            return dateFormatter.format(item[column.dataField]);
        }

    }
}