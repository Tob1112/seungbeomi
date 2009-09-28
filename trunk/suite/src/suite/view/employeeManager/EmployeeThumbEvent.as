package suite.view.employeeManager
{

import flash.events.Event;

import suite.model.vo.Employee;

public class EmployeeThumbEvent extends Event
{
    public static const PURCHASE:String = "purchase";
    public static const COMPARE:String = "compare";
    public static const DETAILS:String = "details";
    public static const BROWSE:String = "browse";

    public var employee:Employee;

    public function EmployeeThumbEvent(type:String, employee:Employee)
    {
        super(type);
        this.employee = employee;
        trace("[ EmployeeThumbEvent.as ] EmployeeThumbEvent(type:" + type + ", employee:" + employee.name + ")")
    }

    override public function clone():Event
    {
    	trace("[ EmployeeThumbEvent.as ] clone()")
        return new EmployeeThumbEvent(type, employee);
    }
}

}