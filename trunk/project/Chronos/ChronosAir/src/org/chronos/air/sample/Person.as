package org.chronos.air.sample
{
	[RemoteClass(alias="org.chronos.appengine.sample.Person")]
	[Bindable]
	public class Person
	{
		public var id:String;
		public var name:String;

	}
}