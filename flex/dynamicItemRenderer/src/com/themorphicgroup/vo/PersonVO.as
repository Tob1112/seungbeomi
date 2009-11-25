package com.themorphicgroup.vo
{
	public class PersonVO extends BaseVO
	{
		public static const GENDER_FEMALE:String = "female";
		public static const GENDER_MALE:String = "male";
		
		private var _lastname:String;
		[Bindable]
		public function set lastname(value:String):void {
			_lastname = value;
		}
		public function get lastname():String {
			return _lastname;
		}
		
		private var _quote:String;
		[Bindable]
		public function set quote(value:String):void {
			_quote = value;
		}
		public function get quote():String {
			return _quote;
		}
		
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
		public function PersonVO()
		{
		}
		

	}
}