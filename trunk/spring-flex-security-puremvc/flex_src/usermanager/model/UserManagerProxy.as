package usermanager.model
{
	import mx.collections.ArrayCollection;

	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;

	public class UserManagerProxy extends Proxy implements IProxy
	{
		public static const NAME: String = "UserManagerProxy";

		public function UserManagerProxy(data:Object = null)
		{
			super(NAME, data);
		}

		public function getUsers():void{

		}

	}
}