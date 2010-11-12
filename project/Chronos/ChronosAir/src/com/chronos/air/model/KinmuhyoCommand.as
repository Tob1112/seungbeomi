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
				case KinmuhyoEvent.FIND_MAX_NENGETSU:	// 新規作成時年月最大値取得
					findMaxNengetsu();
					break;
				case KinmuhyoEvent.KINMUHYO_HOZON:	// 勤務表保存
					kinmuhyoHozon();
					break;
			}
		}

		/** 新規作成時年月最大値取得 */
		private function findMaxNengetsu():void {
			var event:DAOEvent = new DAOEvent(DAOEvent.FIND_MAX_NENGETSU);
			event.dispatch();
			
			// 勤務表新規作成ウィンドウに表示する年月設定
			
		}

		/** 勤務表保存 */
		private function kinmuhyoHozon():void {
			var event:DAOEvent = new DAOEvent(DAOEvent.KINMUHYO_HOZON);
			event.dispatch();
		}


	}
}