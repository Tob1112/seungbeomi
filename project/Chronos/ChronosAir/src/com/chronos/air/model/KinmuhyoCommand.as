package com.chronos.air.model {

	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.chronos.air.event.DAOEvent;
	import com.chronos.air.event.KinmuhyoEvent;
	import com.chronos.air.view.KinmuhyoView;

	public class KinmuhyoCommand implements ICommand{

		private var model:KinmuhyoModel = KinmuhyoModel.getInstance();
		private var view:KinmuhyoView;

		public function execute(e:CairngormEvent):void {
			view = KinmuhyoEvent(e).view as KinmuhyoView;

			switch (e.type) {
				case KinmuhyoEvent.GET_MAX_NENGETSU:	// 新規作成時年月最大値取得
					findMaxNengetsu();
					break;
				case KinmuhyoEvent.GET_JIKOKUHYO:		// 時刻表取得
					findJikokuhyo();
					break;
			}
		}

		/** 新規作成時年月最大値取得 */
		private function findMaxNengetsu():void {
			var event:DAOEvent = new DAOEvent(DAOEvent.FIND_MAX_NENGETSU);
			event.dispatch();
		}

		/** 時刻表取得 */
		private function findJikokuhyo():void {
			var event:DAOEvent = new DAOEvent(DAOEvent.FIND_JIKOKUHYO);
			event.dispatch();
		}

	}
}