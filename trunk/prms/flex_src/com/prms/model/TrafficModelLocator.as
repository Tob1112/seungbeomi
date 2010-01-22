package com.prms.model {
	import com.prms.vo.Traffic;
	import com.prms.vo.TrafficRegular;

	import mx.collections.ArrayCollection;

	[Bindable]
	public class TrafficModelLocator {

		/** 交通費（月） */
		public var traffic:Traffic = new Traffic();
		public var trafficRegular:TrafficRegular = new TrafficRegular();

		/** 交通費定期 - 定期券ArrayCollection */
		public var regTrainAC:ArrayCollection = new ArrayCollection();

		/** 交通費 */
		public var trafficUserListAC:ArrayCollection = new ArrayCollection();

		static private var instance:TrafficModelLocator = null;

		static public function getInstance():TrafficModelLocator {

			if (instance == null) {
				instance = new TrafficModelLocator();
			}
			return instance;
		}

	}
}