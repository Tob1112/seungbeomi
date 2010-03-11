package org.april27.model {

    [RemoteClass(alias="org.april27.model.AuthorizationData")]
    [Bindable]
	public class AuthorizationData {

        public var username:String;
        public var password:String;
        public static var roles:Array = new Array();

        public static function isAdmin():Boolean {
            return hasRole("ADMIN");
        }

        public static function hasRole(role:String):Boolean {
            for (var i:String in roles) {
                if (roles[i] == role) return true;
            }
            return false;
        }

        public static function isAuthorized():Boolean {
            return (roles.length != 0 ) ? true : false;
        }

	}
}