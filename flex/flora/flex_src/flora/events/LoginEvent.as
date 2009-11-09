package flora.events {
	import com.adobe.cairngorm.control.CairngormEvent;

	import flora.views.LoginWindow;
	import flora.vo.User;


    public class LoginEvent extends CairngormEvent {

		public static const EVENT_ID:String = "login";

    	public var user:User;
    	public var doc:LoginWindow;

        public function LoginEvent(user:User, doc:LoginWindow) {
        	super(EVENT_ID);
        	this.user = user;
        	this.doc = doc;
        }

    }
}