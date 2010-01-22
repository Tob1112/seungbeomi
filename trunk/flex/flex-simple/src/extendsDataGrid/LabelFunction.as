package extendsDataGrid
{
	import mx.controls.dataGridClasses.DataGridColumn;
	import mx.formatters.DateFormatter;

	public class LabelFunction
	{
		public function LabelFunction()
		{
		}

		// money
		public static function moneyFormat(item:Object,column:DataGridColumn):String {
			if (item[column.dataField] == null) return "";

			var temp:String = String(item[column.dataField]);
			return LabelFormat.moneyFormat(temp,0);
		}

		//data
		public static function dayFormat(item:Object, column:DataGridColumn):String {
			if (item[column.dataField] == null && item[column.dataField] == "null") return "";

			var temp:String = String(item[column.dataField]);

			if (item[column.dataField] is Date) {
				var df:DateFormatter = new DateFormatter();
				df.formatString = "YYYY-MM-DD";
				return df.format(item[column.dataField]);
			} else {
				return LabelFormat.dayFormat(temp);
			}
		}

	}
}