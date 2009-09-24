package suite.view
{

import flash.events.Event;

import suite.model.vo.Employee;

public class EmployeeListEvent extends Event
{
    public static const ADD_EMPLOYEE:String = "addEmployee";
    public static const DUPLICATE_EMPLOYEE:String = "duplicateEmployee";
    public static const REMOVE_EMPLOYEE:String = "removeEmployee";
    public static const EMPLOYEE_QTY_CHANGE:String = "employeeQtyChange";

    public var employee:Employee;

    //making the default bubbles behavior of the event to true since we want
    //it to bubble out of the EmployeeListItem and beyond
    public function EmployeeListEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false)
    {
        super(type, bubbles, cancelable);
    }

}

}