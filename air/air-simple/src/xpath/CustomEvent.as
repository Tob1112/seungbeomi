package xpath
{
    import flash.events.Event;

    public class CustomEvent extends Event
    {
        //--------- Constant declaration for Event type --------
        public static const XML_DONE:String = "XMLDONE";

        public function CustomEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
        {
            trace("CustomEvent.XML_DONE");
            super(type, bubbles, cancelable);
        }

    }
}

