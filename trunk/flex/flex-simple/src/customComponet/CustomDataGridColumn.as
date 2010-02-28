package customComponet {

	import mx.controls.dataGridClasses.DataGridColumn;
	import mx.core.ClassFactory;

    public class CustomDataGridColumn extends DataGridColumn{

        private var _type:String;

        public function CustomDataGridColumn(columnName:String=null) {
        	super(columnName);
        	setStyle("textAlign", "center");
        }

        [Inspectable(defaultValue="textInput", enumeration="textInput,checkBox")]
        public function set type(type:String):void {
            _type = type;

            var textInputFactory:ClassFactory = new ClassFactory(TextInputRenderer);
            var checkBoxFactory:ClassFactory = new ClassFactory(CheckBoxRenderer);

            switch (type) {
            case "textInput":
                textInputFactory.properties = {color:"red",dataField:this.dataField};
                itemRenderer = textInputFactory;
                break;
            case "checkBox":
                checkBoxFactory.properties = {cccLabel:"test",dataField:this.dataField};
                itemRenderer = checkBoxFactory;
                break;
            }
        }
    }
}