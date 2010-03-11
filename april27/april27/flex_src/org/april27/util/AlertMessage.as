package org.april27.util {

	import mx.controls.Alert;

    public class AlertMessage {

        public static function info(message:String):void {
            Alert.show(message, "APRIL27 INFO");
        }
        public static function debug(message:String):void {
            Alert.show(message, "APRIL27 DEBUG");
        }
        public static function warn(message:String):void {
            Alert.show(message, "APRIL27 WARN");
        }
    }
}