package chapter01.section10 {

    import mx.containers.Canvas;
    import mx.controls.Image;
    import mx.controls.Text;

    //----------------------------------
    //	<mx:Object id="person" name="son" age="30" position="500" image="http://www.gstatic.com/codesite/ph/images/defaultlogo.png"/>
	//	<section10:ActionscriptComponent data="{person}"/>
	//----------------------------------

    public class ActionscriptComponent extends Canvas {

    	private var _data:Object;
    	private var nameText:Text;
    	private var ageText:Text;
    	private var positionText:Text;
    	private var image:Image;

        public function ActionscriptComponent() {
        	super();
        	nameText = new Text();
        	addChild(nameText);

        	ageText = new Text();
        	addChild(ageText);
        	ageText.y = 20;

        	positionText = new Text();
        	addChild(positionText);
        	positionText.y = 40;

        	image = new Image();
        	addChild(image);
        	image.y = 60;
        }

        override public function set data(value:Object):void {
        	_data = value;
        	nameText.text = value.name;
        	ageText.text = String(value.age);
        	positionText.text = value.position;
        	image.source = value.image;
        }

        override public function get data():Object {
        	return _data;
        }
    }
}