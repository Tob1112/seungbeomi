package flora.events {
	import com.adobe.cairngorm.control.CairngormEvent;

	import flora.vo.User;


    public class LoginEvent extends CairngormEvent {

		public static const EVENT_LOGIN:String = "eventLogin";

    	public var user:User;

        public function LoginEvent(type:String, obj:Object) {
        	trace("LoginEvent - type:" + type);
        	super(type);
        	this.user = obj as User;
        }

    }
}