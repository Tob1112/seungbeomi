package com.chronos
{
	import com.adobe.cairngorm.control.FrontController;
	import com.chronos.air.event.DAOEvent;
	import com.chronos.air.event.KinmuhyoEvent;
	import com.chronos.air.event.ShinseiServiceEvent;
	import com.chronos.air.model.DAOCommand;
	import com.chronos.air.model.KinmuhyoCommand;
	import com.chronos.air.model.ShinseiServiceCommand;
	import com.chronos.air.sample.PersonCommand;
	import com.chronos.air.sample.PersonEvent;

	public class Controller extends FrontController
	{
		public function Controller()
		{
			super();

			// DAO ---------------------------------------------------------------
			addCommand(DAOEvent.OPEN_DATABASE, DAOCommand);	// database 解放
			addCommand(DAOEvent.SAVE_SHAIN, DAOCommand);		// ユーザー情報保存
			addCommand(DAOEvent.FIND_KINMUHYO, DAOCommand); // 勤務表リスト検索
			addCommand(DAOEvent.FIND_MAX_NENGETSU, DAOCommand);	// 勤務表年月最大値取得
			//addCommand(DAOEvent.FIND_JIKOKUHYO, DAOCommand);	// 時刻表取得

			// 勤務表 --------------------------------------------------------------
			addCommand(KinmuhyoEvent.GET_MAX_NENGETSU, KinmuhyoCommand); // 勤務表年月最大値取得
			addCommand(KinmuhyoEvent.INITIALIZE_KINMUHYO_DATA, KinmuhyoCommand); // 勤務表データ初期化

			// 申請サービス ---------------------------------------------------------
			addCommand(ShinseiServiceEvent.LOGIN, ShinseiServiceCommand);	// ログイン
			addCommand(ShinseiServiceEvent.LOGOUT, ShinseiServiceCommand);	// ログアウト


			// sample --------------------------------------------------------------
			addCommand(PersonEvent.SAY_HELLO, PersonCommand);
			addCommand(PersonEvent.FILE_UPLOAD, PersonCommand);

		}

	}
}