package org.chronos.air.sample
{
	import com.adobe.cairngorm.control.CairngormEvent;

	public class PersonEvent extends CairngormEvent
	{
		public static const SAY_HELLO:String = "sayHello";
		public static const FILE_UPLOAD:String = "fileUpload";

		public var view:Object;

		public function PersonEvent(type:String, doc:Object=null)
		{
			super(type);
			view = doc;
		}
	}
}