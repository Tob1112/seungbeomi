package suite.model.vo
{
	import mx.collections.ArrayCollection;


	[Bindable]
	public class Employee
	{
	    public var employeeId:int;
	    public var name:String;
		public var email:String;
		public var address:String;
		public var company:String;
		public var department:String;
	    public var image:String;

	    public function Employee()
	    {

	    }

	    public function fill(obj:Object):void
	    {
	    	this.employeeId = obj.employeeId;
	    	this.name = obj.name;
	    	this.email = obj.email;
	    	this.address = obj.address;
	    	this.company = obj.company;
	    	this.department = obj.department;
	    	this.image = obj.image;
	    }
	}
}