package business.commands
{

	import business.delegates.PhotoDelegate;
	
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import model.ModelLocator;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.Responder;
	import mx.rpc.events.ResultEvent;
	
	import valueObjects.Photo;

	public class LoadPhotosCommand implements ICommand
	{
		private var __model:ModelLocator=ModelLocator.getInstance();
		                                     
		
		public function execute(event:CairngormEvent):void
		{
			/*
			var service:HTTPService=__locator.getHTTPService("photosIn");
			service.addEventListener(ResultEvent.RESULT,onResults_loadPhotos);
			service.send();
			*/
			var responder:Responder = new Responder(onResults_loadPhotos, null);
			var delegate:PhotoDelegate = new PhotoDelegate(responder);
			delegate.loadPhotos();
		}
		private function onResults_loadPhotos(event:ResultEvent):void
		{
			var photoRaw:ArrayCollection=event.result.photos.image;
			for(var i:int=0;i<photoRaw.length;i++)
			{
				var tempPhoto:Photo=new Photo();
				var photoFromAC:Object=photoRaw.getItemAt(i);
				tempPhoto.filename=photoFromAC.filename;
				tempPhoto.photographer=photoFromAC.photographer;
				tempPhoto.desc=photoFromAC.desc;
				tempPhoto.category=photoFromAC.category;
				__model.photoData.addItem(tempPhoto);					
			}
		}
	}
}