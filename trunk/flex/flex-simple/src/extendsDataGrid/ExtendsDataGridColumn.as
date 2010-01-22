package extendsDataGrid
{
	import mx.controls.dataGridClasses.DataGridColumn;
	import mx.core.ClassFactory;

	public class ExtendsDataGridColumn extends DataGridColumn
	{
		private var _type:String = "";

		public function ExtendsDataGridColumn(columnName:String=null)
		{
			super(columnName);
			this.setStyle("textAlign","center");
			this.headerRenderer = new ClassFactory(HeaderRenderer);
		}

		[Inspectable(defaultValue="money", enumeration="money,date")]
		public function set format(type:String):void {
			_type = type;

			switch (type) {
				case "money":
					this.labelFunction = LabelFunction.moneyFormat;
					this.setStyle("textAlign","right");
				break;
				case "date":
					this.labelFunction = LabelFunction.dayFormat;
					this.setStyle("textAligh","center");
				break;
				default:
					this.setStyle("textAligh","center");
			}
		}

	}
}