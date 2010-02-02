package com.prms.client.flex.util.fommater {
    import mx.controls.dataGridClasses.DataGridColumn;
    import mx.formatters.DateFormatter;

    public class LabelDateFormatter {
        private var dateFormatter:DateFormatter;

        public function LabelDateFormatter() {
            dateFormatter = new DateFormatter();
            //dateFormatter.formatString = "YYYY/MM/DD(EEE)";
        }

        public function formatYYYY(item:Object, column:DataGridColumn):String {
            dateFormatter.formatString = "YYYY";
            return dateFormatter.format(item[column.dataField]);
        }

        public function formatMM(item:Object, column:DataGridColumn):String {
            dateFormatter.formatString = "MM";
            return dateFormatter.format(item[column.dataField]);
        }

        public function formatYYYYMM(value:Date):String {
        	dateFormatter.formatString = "YYYYMM";
            return dateFormatter.format(value);
        }
    }
}