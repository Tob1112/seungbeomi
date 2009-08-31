package spring.flex {
	import spring.flex.dto.User;
	import mx.controls.Alert;

	[Bindable]
	public class UserModel 	{
		public var user:User = new User();
		//public var listRoles:String = "";

		public function isAdmin():Boolean {
			return hasRole("ROLE_ADMIN");
		}

		public function isUser():Boolean {
			return hasRole("ROLE_USER");
		}

		private function hasRole(role:String):Boolean {
			for (var i:String in user.groups) {
				if (user.groups[i] == role) {
					return true
				}
			}
			return false;
		}
	}
}