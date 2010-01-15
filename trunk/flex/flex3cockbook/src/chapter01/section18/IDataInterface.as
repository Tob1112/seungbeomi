package chapter01.section18
{
	public interface IDataInterface
	{
		function set dataType(value:Object):void;

		function get dataType():Object;

		function update():Boolean;

		function write():Boolean;

		function readData():Object;
	}
}