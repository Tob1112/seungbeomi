package suite.model.vo
{

[Bindable]
public class Employee
{

    public var employeeId:int;
    public var name:String;
    public var description:String;
    public var price:Number;
    public var image:String;
    public var series:String;
    public var triband:Boolean;
    public var camera:Boolean;
    public var video:Boolean;
    public var highlight1:String;
    public var highlight2:String;
    public var qty:int;

    public function Employee()
    {

    }

    public function fill(obj:Object):void
    {
    	trace("[ Employee.as ] fill(obj:Object)")
        for (var i:String in obj)
        {
            this[i] = obj[i];
        }
    }

    [Bindable(event="propertyChange")]
    public function get featureString():String
    {
    	trace("[ Employee.as ] get featureString()")

    	var str:String = "";
    	if (triband)
    		str += "Tri-band ";

		if (camera)
			str += "Camera ";

		if (video)
			str += "Video";

		return str;
    }

}

}