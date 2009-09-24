package suite.model.vo
{

	[Bindable]
	public class Employee
	{

	    public var employeeId:int;
	    public var name:String;
	    public var department:String;
	    public var image:String;
	    public var address:String;


	    public function Employee() {

	    }

	    public function fill(obj:Object):void {
	        for (var i:String in obj) {
	            this[i] = obj[i];
	        }
	    }

	}

}