package org.chronos.model {

    [RemoteClass(alias="org.chronos.model.Employee")]
    [Bindable]
    public class Employee {

        public var empName:String;
        public var password:String;
        public var email:String;

    }
}