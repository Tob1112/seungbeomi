package customComponet {

    import mx.controls.TextInput;

    public class TextInputRenderer extends TextInput {

    	public var color:uint;
    	public var dataField:String;

        public function TextInputRenderer() {
        	super();
        }

        override public function set data(value:Object):void {
            super.data = value;
            trace(data);
        }
    }
}