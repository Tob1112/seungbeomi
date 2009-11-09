package business.events
{
	import com.adobe.cairngorm.control.CairngormEvent;

	public class LoadPhotosEvent extends CairngormEvent
	{
		static public var EVENT_ID:String="loadPhotos";
		
		public function LoadPhotosEvent()
		{
			super(EVENT_ID);
		}
	}
}