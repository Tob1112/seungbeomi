package org.april27.home {

    import com.adobe.cairngorm.control.CairngormEvent;

    public class HomeEvent extends CairngormEvent {

        public static const AUTHENTICATE_USER:String = "authenticateUser";   // login

        public var view:HomeView;

        public function HomeEvent(type:String, view:HomeView=null) {
        	super(type);
        	this.view = view;
        }
    }
}