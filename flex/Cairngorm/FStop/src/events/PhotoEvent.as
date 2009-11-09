package events
{
	import flash.events.Event;
	
	import valueObjects.Photo;

	public class PhotoEvent extends Event
	{
		public var selectedPhoto:Photo;
		
		public function PhotoEvent(type:String, selectedPhoto:Photo)
		{
			super(type);
			this.selectedPhoto=selectedPhoto;
		}
		override public function clone():Event
		{
			return new PhotoEvent(type,selectedPhoto);	
		}
	}
}