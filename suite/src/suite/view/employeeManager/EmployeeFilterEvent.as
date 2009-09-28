package suite.view.employeeManager
{

import flash.events.Event;

public class EmployeeFilterEvent extends Event
{
    public static const FILTER:String = "filter";

    public var live:Boolean;
    public var filter:EmployeeFilter;

    public function EmployeeFilterEvent(filter:EmployeeFilter, live:Boolean)
    {
        super(FILTER);
        this.filter = filter;
        this.live = live;
        trace("[ EmployeeFilterEvent.as ] EmployeeFilterEvent(filter:EmployeeFilter, live:Boolean)")
    }
}

}