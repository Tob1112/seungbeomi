package com.themorphicgroup.vo
{
	public class BaseVO
	{
		
		private var _name:String;
		[Bindable]
		public function set name(value:String):void {
			_name = value;
		}
		public function get name():String {
			return _name;
		}
		
		private var _email:String;
		[Bindable]
		public function set email(value:String):void {
			_email = value;
		}
		public function get email():String {
			return _email;
		}

	    public function fill(obj:Object):void {
	        for (var i:String in obj) {
	            this[i] = obj[i];
	        }
	    }
		
	}
}