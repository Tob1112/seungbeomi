package model
{
	import mx.collections.ArrayCollection;
	
	[Bindable]
	public class ModelLocator
	{
		public var photoData:ArrayCollection=new ArrayCollection();
		public var purchasedPhotos:ArrayCollection=new ArrayCollection();
		static private var __instance:ModelLocator=null;
		
		static public function getInstance():ModelLocator
		{
			if(__instance == null)
			{
				__instance=new ModelLocator();
			}
			return __instance;
		}
	}
}