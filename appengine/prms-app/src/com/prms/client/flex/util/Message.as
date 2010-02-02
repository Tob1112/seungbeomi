package com.prms.client.flex.util {
    import mx.controls.Alert;
    import mx.rpc.events.FaultEvent;
    import mx.rpc.events.ResultEvent;

    /**
     * メッセージ
     * @author 孫承範
     */
    [RemoteClass(alias = "com.prms.client.flex.model.Message")]
    [Bindable]
    public class Message {
        private static const SERVER_ACCESS_ERROR_MESSAGE:String = "サーバーへのアクセスエラーが発生しました。";

        /** メッセージ区分 */
        public var msgType:String;

        /** メッセージID */
        public var msgId:String;

        /** メッセージ */
        public var msgBody:String;

        public static function showResultMessage(event:ResultEvent):void {
            Alert.show(event.result.toString());
        }

        public static function showErrorMessage(event:FaultEvent):void {
            var message:String = event.fault.faultString;

            if (message !=   "error") {
                //Alert.show(message.substr(45), "PRMS ERROR");
                Alert.show(message, "PRMS ERROR");
            } else {
                Alert.show(SERVER_ACCESS_ERROR_MESSAGE, "PRMS ERROR");
            }

        }
    }
}