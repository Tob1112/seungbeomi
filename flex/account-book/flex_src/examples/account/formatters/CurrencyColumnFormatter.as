package examples.account.formatters {
    import mx.controls.dataGridClasses.DataGridColumn;
    import mx.formatters.CurrencyFormatter;

    public class CurrencyColumnFormatter {
        private var currencyFormatter:CurrencyFormatter;

        public function CurrencyColumnFormatter() {
            currencyFormatter=new CurrencyFormatter();
        }

        public function format(item:Object, column:DataGridColumn):String {
            return currencyFormatter.format(item[column.dataField]);
        }

    }
}