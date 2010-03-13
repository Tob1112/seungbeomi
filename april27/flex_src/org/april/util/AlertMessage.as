package org.april.util {

	import mx.controls.Alert;

    public class AlertMessage {

        public static function info(message:String):void {
            Alert.show(message, "APRIL INFO");
        }
        public static function debug(message:String):void {
            Alert.show(message, "APRIL DEBUG");
        }
        public static function warn(message:String):void {
            Alert.show(message, "APRIL WARN");
        }
    }
}