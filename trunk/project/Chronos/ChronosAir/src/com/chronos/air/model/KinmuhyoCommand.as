package com.chronos.air.model {

	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;

	public class KinmuhyoCommand implements ICommand {

		[Bindable]
		private var model:KinmuhyoModelLocator = KinmuhyoModelLocator.getInstance();

		public function execute(e:CairngormEvent):void {

		}

	}
}