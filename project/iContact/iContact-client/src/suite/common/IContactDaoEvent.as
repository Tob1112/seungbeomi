package suite.common
{
	import com.adobe.cairngorm.control.CairngormEvent;

	public class IContactDaoEvent extends CairngormEvent
	{
		public static const OPEN_DATABASE:String = "openDatabase";

		public function IContactDaoEvent(type:String):void
		{
			super(type);
		}

	}
}