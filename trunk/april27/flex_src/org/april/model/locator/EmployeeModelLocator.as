package org.april.model.locator {

	import mx.collections.ArrayCollection;

	import org.april.model.Employee;

    [Bindable]
    public class EmployeeModelLocator {

    	public var employee:Employee = new Employee();

    	public var employeeAC:ArrayCollection = new ArrayCollection();

    	private static var instance:EmployeeModelLocator = null;

        public static function getInstance():EmployeeModelLocator {
        	if (instance == null) instance = new EmployeeModelLocator();
        	return instance;
        }
    }
}