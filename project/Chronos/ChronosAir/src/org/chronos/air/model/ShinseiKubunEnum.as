package org.chronos.air.model
{
	[Bindable]
	public class ShinseiKubunEnum
	{
		public static const KINMUHYO:ShinseiKubunEnum		 = new ShinseiKubunEnum("1", "勤務表");
		public static const KOTSUHI:ShinseiKubunEnum		 = new ShinseiKubunEnum("2", "交通費");

		public var code:String;
		public var value:String;

		public function ShinseiKubunEnum(code:String, value:String) {
			this.code = code;
			this.value = value;
		}

	}
}