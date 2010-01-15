package chapter01.section18
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;

	public class ClientData extends EventDispatcher
	{
		private var _dataType:Object;

		public function ClientData(target:IEventDispatcher=null)
		{
			super(target);
		}

		public function set dataType(value:Object):void {
			trace("set dataType - " + value);
			_dataType = value;
		}

		public function get dataType():Object {
			trace("get dataType");
			return _dataType;
		}

		public function update():Boolean{
			trace("update");
			return true;
		}


		public function write():Boolean{
			trace("write");
			return true;
		}


		public function readData():Object{
			trace("readData");
			return Object;
		}


	}
}