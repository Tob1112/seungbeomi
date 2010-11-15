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
				case KinmuhyoEvent.SAVE_KINMUHYO:	// 勤務表保存
					saveKinmuhyo();
					break;
				case KinmuhyoEvent.FIND_KINMUHYO_SHOSAI:	// 勤務表詳細検索
					findKinmuhyoShosai();
					break;
			}
		}
		
		//----------------------------------------------------------------------------------------------

		/** 新規作成時年月最大値取得 */
		private function findMaxNengetsu():void {
			var event:DAOEvent = new DAOEvent(DAOEvent.FIND_MAX_NENGETSU);
			event.dispatch();

			// 勤務表新規作成ウィンドウに表示する年月設定

		}

		/** 勤務表保存 */
		private function saveKinmuhyo():void {
			var event:DAOEvent = new DAOEvent(DAOEvent.SAVE_KINMUHYO);
			event.dispatch();
		}

		/** 勤務表詳細検索 */
		private function findKinmuhyoShosai():void {
			var event:DAOEvent = new DAOEvent(DAOEvent.FIND_KINMUHYO_SHOSAI);
			event.dispatch();

			// 勤務表DateChooser更新
			var nengetsuArray:Array = model.nengetsu.split("-");
			view.kinmuhyoDateChooser.displayedYear = nengetsuArray[0];
			view.kinmuhyoDateChooser.displayedMonth = nengetsuArray[1] - 1;
		}
	}
}