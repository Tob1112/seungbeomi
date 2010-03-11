package org.april27.authentication {

	import com.adobe.cairngorm.control.CairngormEvent;

	public class AuthenticationEvent extends CairngormEvent{

		public static const AUTHENTICATE_USER:String = "authenticateUser";   // login

		public var view:Object;

		public function AuthenticationEvent(type:String, view:Object=null) {
			super(type);
			this.view = view;
		}

	}
}