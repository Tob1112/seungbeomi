package org.chronos.air.model {
	import flash.filesystem.File;


	[Bindable]
	public class ApplicationModel {

		public var shain:Shain = new Shain();
		public var file:File = new File();
		public var shinsei:Shinsei = new Shinsei();

		private static var instance:ApplicationModel = null;

		public static function getInstance():ApplicationModel {
			if (instance == null) {
				instance = new ApplicationModel();
			}
			return instance;
		}
	}
}