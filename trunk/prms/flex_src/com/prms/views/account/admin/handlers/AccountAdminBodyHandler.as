import com.adobe.cairngorm.control.CairngormEventDispatcher;
import mx.messaging.messages.RemotingMessage;

private function creationCompleteHandler():void {
    registerClassAlias("flex.messaging.messages.RemotingMessage", RemotingMessage);
}