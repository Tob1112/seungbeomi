package addchild {
    import mx.containers.VBox;
    import mx.controls.Label;

    public class AddChildTest extends VBox {
        protected override function createChildren():void {
        	var a:Label = new Label();
        	a.text = "label one";
        	this.addChild(a);
        	var b:Label = new Label();
        	b.text = "label two";
        	this.addChild(b);
        	var c:Label = new Label();
        	c.text = "label three";
        	this.addChild(c);
        }
    }
}