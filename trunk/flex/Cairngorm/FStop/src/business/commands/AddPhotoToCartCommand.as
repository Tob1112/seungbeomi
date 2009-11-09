package business.commands
{
	import business.events.AddPhotoToCartEvent;
	
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import model.ModelLocator;
	
	import valueObjects.Photo;

	public class AddPhotoToCartCommand implements ICommand
	{
		private var __model:ModelLocator=ModelLocator.getInstance();
		
		public function execute(event:CairngormEvent):void
		{
			var photo:Photo=(event as AddPhotoToCartEvent).photo;
			__model.purchasedPhotos.addItem(photo);
		}
	}
}