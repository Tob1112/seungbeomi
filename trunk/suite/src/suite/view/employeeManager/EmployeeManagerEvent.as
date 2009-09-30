package suite.view.employeeManager
{
	import flash.events.Event;

	import suite.model.vo.Employee;

	public class EmployeeManagerEvent extends Event
	{

		public static const SHOW_DETAILS:String = "showDetails";
		public static const SHOW_THUMB_LIST:String = "showThumbList";

		public var employee:Employee;

		public function EmployeeManagerEvent(type:String, employee:Employee)
		{
			super(type);
			this.employee = employee;
		}

	}
}