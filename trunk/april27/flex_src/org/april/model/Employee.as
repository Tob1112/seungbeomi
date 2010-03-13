package org.april.model {

    [RemoteClass(alias="org.april.model.Employee")]
    [Bindable]
    public class Employee {

        public var empName:String;
        public var password:String;
        public var email:String;

    }
}