package org.chronos.util {

	import mx.controls.Alert;

    public class AlertMessage {

        public static function info(message:String):void {
            Alert.show(message, "CHRONOS INFO");
        }
        public static function debug(message:String):void {
            Alert.show(message, "CHRONOS DEBUG");
        }
        public static function warn(message:String):void {
            Alert.show(message, "CHRONOS WARN");
        }
    }
}