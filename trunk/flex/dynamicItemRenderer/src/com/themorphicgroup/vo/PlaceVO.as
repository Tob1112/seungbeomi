package com.themorphicgroup.vo
{
	public class PlaceVO extends BaseVO
	{

		private var _address:String;
		[Bindable]
		public function set address(value:String):void {
			_address = value;
		}
		public function get address():String {
			return _address;
		}

	}
}