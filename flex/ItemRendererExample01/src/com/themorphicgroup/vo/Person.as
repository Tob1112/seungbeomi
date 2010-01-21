package com.themorphicgroup.vo
{
	public class Person
	{
		public static const GENDER_FEMALE:String = "female";
		public static const GENDER_MALE:String = "male";
		
		[Bindable]public var firstname:String;
		[Bindable]public var lastname:String;
		[Bindable]public var email:String;
		[Bindable]public var quote:String;
		
		/* simplistic example 'get' and 'set' for gender allowing for some data validation */
		private var _gender:String;
		[Bindable]
		public function set gender(value:String):void {
			if (value.toLowerCase() == GENDER_MALE) {
				_gender = GENDER_MALE;
			} else {
				_gender = GENDER_FEMALE;
			}
		}
		public function get gender():String {
			return _gender;
		}
		
		
		/* constructor */
		public function Person()
		{
		}
		
	    public function fill(obj:Object):void {
	        for (var i:String in obj) {
	            this[i] = obj[i];
	        }
	    }
	}
}