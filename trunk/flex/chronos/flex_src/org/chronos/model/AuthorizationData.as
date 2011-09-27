package org.chronos.model {

	import org.chronos.Constants;

    [RemoteClass(alias="org.chronos.model.AuthorizationData")]
    [Bindable]
	public class AuthorizationData {

        public var username:String;
        public var password:String;
        public var roles:Array = new Array();

        public function isAdmin():Boolean {
            return hasRole(Constants.ADMIN);
        }

        public function hasRole(role:String):Boolean {
            for (var i:String in roles) {
                if (roles[i] == role) return true;
            }
            return false;
        }

        public function isAuthorized():Boolean {
            return (roles.length != 0 ) ? true : false;
        }

	}
}