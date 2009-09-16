package sample.model
{
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;

	import sample.model.vo.User;

	public class UserProxy extends Proxy implements IProxy
	{
		public static const NAME:String = "UserProxy";

		public function UserProxy(data:Object = null) {
			 super(NAME, data);
		}

		public function login(username:String, password:String):User {

			trace("<<< input username = " + username + ", password = " + password);

			var user:User = new User(username, password);
			return user;
		}

		public function get user():User {
			return user as User;
		}
	}
}