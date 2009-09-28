package suite.view.employeeManager
{
	import suite.model.vo.Employee;


[Bindable]
public class EmployeeFilter
{
    public var count:int;
    public var series:String;
    public var minPrice:Number;
    public var maxPrice:Number;
    public var triband:Boolean;
    public var camera:Boolean;
    public var video:Boolean;

    public function EmployeeFilter()
    {
        super();
        trace("[ EmployeeFilter.as ] EmployeeFilter()")
    }

    public function accept(employee:Employee):Boolean
    {
    	trace("[ EmployeeFilter.as ] accept(employee:" + employee.name + ")")
        //price is often the first test so let's fail fast if possible
        if (minPrice > employee.price || maxPrice < employee.price)
            return false;
        if (series != "All Series" && series != employee.series)
            return false;
        if (triband && !employee.triband)
            return false;
        if (camera && !employee.camera)
            return false;
        if (video && !employee.video)
            return false;

        return true;
    }
}

}