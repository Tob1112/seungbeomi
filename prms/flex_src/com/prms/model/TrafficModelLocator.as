package com.prms.model {
	import com.prms.vo.Traffic;

	import mx.collections.ArrayCollection;

	[Bindable]
	public class TrafficModelLocator {

		/** 交通費定期 - 定期券ArrayCollection */
		public var regTrainAC:ArrayCollection = new ArrayCollection();

		/** 交通費（月） */
		public var traffic:Traffic = new Traffic();

		static private var instance:TrafficModelLocator = null;

		static public function getInstance():TrafficModelLocator {

			if (instance == null) {
				instance = new TrafficModelLocator();
			}
			return instance;
		}

	}
}