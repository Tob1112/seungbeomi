package com.prms.client.flex.util.fommater {

    public class EmpNameFormatter {
        public static function setEmpName(lastName:String, firstName:String):String {
            var empName:String = lastName + "  " + firstName;
            return empName;
        }
    }
}