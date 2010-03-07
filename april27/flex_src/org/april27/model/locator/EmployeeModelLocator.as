package org.april27.model.locator {

	import mx.collections.ArrayCollection;

	import org.april27.model.Employee;

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