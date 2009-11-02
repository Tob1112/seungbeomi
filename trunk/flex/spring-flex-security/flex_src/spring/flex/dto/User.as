package spring.flex.dto {

	[RemoteClass(alias="seungbeomi.user.model.User")]
	[Bindable]
	public class User {
		public var userId:String;
		public var password:String;
		public var name:String;
		public var email:String;
		public var groupId:String;
		public var groups:Array;
	}
}