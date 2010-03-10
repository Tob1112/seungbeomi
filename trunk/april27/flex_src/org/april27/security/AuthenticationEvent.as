package org.april27.security {

	import com.adobe.cairngorm.control.CairngormEvent;

	public class AuthenticationEvent extends CairngormEvent{

		public static const AUTHENTICATE_USER:String = "authenticateUser";   // login

		public var doc:AuthenticationForm;

		public function AuthenticationEvent(type:String, doc:AuthenticationForm) {
			super(type);
			this.doc = doc;
		}

	}
}