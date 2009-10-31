package examples.account.events {
    import flash.events.Event;

    public class RecordUpdateWindowEvent extends Event {
        public static const UPDATE_COMPLETE:String="recordUpdateComplete";

        public function RecordUpdateWindowEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) {
            super(type, bubbles, cancelable);
        }
    }
}