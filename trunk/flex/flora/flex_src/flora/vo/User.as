package flora.vo
{
	import com.adobe.cairngorm.vo.ValueObject;

	[RemoteObject(alias="flora.model.User")]
	[Bindable]
	public class User implements ValueObject
	{
		public var userId:String;
		public var password:String;
		public var roles:Array;

		public function isAdmin():Boolean {
			return hasRole("ROLE_ADMIN");
		}

		public function isUser():Boolean {
			return hasRole("ROLE_USER");
		}

		private function hasRole(role:String):Boolean {
			for (var i:String in roles) {
				if (roles[i] == role) {
					return true
				}
			}
			return false;
		}
	}
}