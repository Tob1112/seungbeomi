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

		public function login(username:String, password:String):void {
			data = new User(username, password);
		}

		public function get user():User {
			return data as User;
		}
	}
}