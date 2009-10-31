package examples.account {
    import mx.formatters.CurrencyFormatter;

    [Bindable]
    public class AccountBookMainModel {
        public var txyear:int;

        public var txmonth:int;

        public var totalprice:String;

        private var curFormatter:CurrencyFormatter=new CurrencyFormatter();

        public function AccountBookMainModel() {
        }

        public function setTotalPrice(total:int):void {
            totalprice=curFormatter.format(total);
        }

    }
}