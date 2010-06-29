package com.tis.XpathExample
{
    import flash.events.Event;

    public class CustomEvent extends Event
    {
        //--------- Constant declaration for Event type --------
        public static const XML_DONE:String = "XMLDONE";

        public function CustomEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
        {
            super(type, bubbles, cancelable);
        }

    }
}

