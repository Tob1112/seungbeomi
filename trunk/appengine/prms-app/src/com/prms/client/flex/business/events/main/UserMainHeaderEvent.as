package com.prms.client.flex.business.events.main {
    import com.adobe.cairngorm.control.CairngormEvent;

    import mx.modules.ModuleLoader;

    /**
     *
     * @author DEV006
     */
    public class UserMainHeaderEvent extends CairngormEvent {
        static public var EVENT_ID:String = "userMainHeaderSelectedEvent";
        public var status:String = null;
        public var moduleLoader:ModuleLoader = null;


        public function UserMainHeaderEvent(status:String, moduleLoader:ModuleLoader) {
            super(EVENT_ID);
            this.status = status;
            this.moduleLoader = moduleLoader;
        }
    }
}

