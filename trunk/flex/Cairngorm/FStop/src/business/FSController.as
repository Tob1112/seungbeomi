package business
{
	import business.commands.AddPhotoToCartCommand;
	import business.commands.LoadPhotosCommand;
	import business.events.AddPhotoToCartEvent;
	import business.events.LoadPhotosEvent;
	
	import com.adobe.cairngorm.control.FrontController;

	public class FSController extends FrontController
	{
		public function FSController()
		{
			super();
			addCommand(LoadPhotosEvent.EVENT_ID,LoadPhotosCommand);
			addCommand(AddPhotoToCartEvent.EVENT_ID,AddPhotoToCartCommand);
		}
	}
}