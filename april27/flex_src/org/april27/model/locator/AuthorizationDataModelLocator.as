package org.april27.model.locator {

	import mx.collections.ArrayCollection;

	import org.april27.model.AuthorizationData;

	[Bindable]
	public class AuthorizationDataModelLocator {

        public var authorizationData:AuthorizationData = new AuthorizationData();

        public var authorizationDataAC:ArrayCollection = new ArrayCollection();

        public static var instance:AuthorizationDataModelLocator = null;

		public static function getInstance():AuthorizationDataModelLocator {
			if (instance == null) instance = new AuthorizationDataModelLocator();
			return instance;
		}
	}
}