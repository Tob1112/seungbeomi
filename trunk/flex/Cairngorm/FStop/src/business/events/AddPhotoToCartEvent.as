package business.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import valueObjects.Photo;

	public class AddPhotoToCartEvent extends CairngormEvent
	{
		static public var EVENT_ID:String="addPhotoToCart";
		public var photo:Photo=null;
		
		public function AddPhotoToCartEvent(photo:Photo)
		{
			super(EVENT_ID);
			this.photo=photo;
		}
	}
}